#
# Cost and usage
#
resource "aws_glue_crawler" "cur_data_extract" {
  name          = "Cost and Usage Report 2.0"
  database_name = "curdatabase"
  table_prefix  = "cds_cur_export_crawler_"
  role          = aws_iam_role.glue_crawler.arn
  s3_target {
    path = "s3://${data.aws_s3_bucket.cur_data_extract.id}/cds_/CDSCostAndUsage/"
  }

  configuration = jsonencode(
    {
      CrawlerOutput = {
        Tables = {
          TableThreshold = 2
        }
      }
      CreatePartitionIndex = true
      Version              = 1
  })

  # Create the new month's partition key
  schedule = "cron(00 7 1 * ? *)"

  tags = {
    Terraform = "true"
  }
}

#
# Notify
#
resource "aws_glue_crawler" "notify" {
  name          = "Notify"
  database_name = "curdatabase"
  table_prefix  = "cds_cur_export_crawler_notify_"
  role          = aws_iam_role.glue_crawler.arn
  s3_target {
    path = "s3://${module.notify_data_export.s3_bucket_id}/data/NotificationCanadaCastaging/"
  }

  configuration = jsonencode(
    {
      CrawlerOutput = {
        Tables = {
          TableThreshold = 10
        }
      }
      CreatePartitionIndex = true
      Version              = 1
  })

  tags = {
    Terraform = "true"
  }
}

#
# Glue crawler role
#
resource "aws_iam_role" "glue_crawler" {
  name               = "AWSGlueServiceRole-cds_cur_extract_crawler"
  assume_role_policy = data.aws_iam_policy_document.glue_assume.json
  path               = "/service-role/"
  tags = {
    Terraform = "true"
  }
}

data "aws_iam_policy_document" "glue_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "glue.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy" "AWSGlueServiceRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_role_policy_attachment" "glue_attach_policy" {
  policy_arn = data.aws_iam_policy.AWSGlueServiceRole.arn
  role       = aws_iam_role.glue_crawler.name
}

resource "aws_iam_policy" "glue_s3_crawler" {
  name        = "AWSGlueServiceRole-cds_cur_extract_crawler-EZCRC-s3Policy"
  policy      = data.aws_iam_policy_document.glue_s3_crawler.json
  description = "This policy will be used for Glue Crawler and Job execution. Please do NOT delete!"
  path        = "/service-role/"
}

data "aws_iam_policy_document" "glue_s3_crawler" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${data.aws_s3_bucket.cur_data_extract.arn}/*",
      "${module.notify_data_export.s3_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:RetireGrant"
    ]
    resources = [
      aws_kms_key.data_export.arn
    ]
  }
}

resource "aws_iam_role_policy_attachment" "glue_s3_crawler" {
  policy_arn = aws_iam_policy.glue_s3_crawler.arn
  role       = aws_iam_role.glue_crawler.name
}

resource "aws_athena_database" "cur_data_extract_database" {
  name   = "curdatabase"
  bucket = data.aws_s3_bucket.cur_data_extract.id
}

data "aws_s3_bucket" "cur_data_extract_queries" {
  bucket = "calvinrodotestbucket"
}

data "aws_s3_bucket" "cur_tag_etl_output" {
  bucket = "4d9f3f22-cff9-4407-ab55-a0d2373b382e"
}

#
# Glue ETL role
#
resource "aws_iam_role" "glue_etl" {
  name               = "AWSGlueServiceRole-etl"
  assume_role_policy = data.aws_iam_policy_document.glue_assume.json
  path               = "/service-role/"
  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_role_policy_attachment" "glue_etl_service_role" {
  policy_arn = data.aws_iam_policy.AWSGlueServiceRole.arn
  role       = aws_iam_role.glue_etl.name
}

resource "aws_iam_role_policy_attachment" "glue_etl" {
  policy_arn = aws_iam_policy.glue_etl.arn
  role       = aws_iam_role.glue_etl.name
}

resource "aws_iam_policy" "glue_etl" {
  name        = "AWSGlueServiceRole-etl"
  policy      = data.aws_iam_policy_document.glue_etl.json
  description = "This policy is used by the Glue ETL jobs to transform the exported data"
  path        = "/service-role/"
}

data "aws_iam_policy_document" "glue_etl" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${data.aws_s3_bucket.cur_data_extract.arn}/cds_/DailyCostExports/*",
      "${module.notify_data_export.s3_bucket_arn}/*",
      "arn:aws:s3:::5bf89a78-1503-4e02-9621-3ac658f558fb/*",
      "arn:aws:s3:::713f18dd-9f30-4976-a152-e81d48cf053a/*",
      "arn:aws:s3:::4d9f3f22-cff9-4407-ab55-a0d2373b382e/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "athena:*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyWithoutPlaintext",
      "kms:ReEncryptFrom",
      "kms:ReEncryptTo",
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:RetireGrant"
    ]
    resources = [
      aws_kms_key.data_export.arn
    ]
  }
}
