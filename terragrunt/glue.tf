
resource "aws_glue_crawler" "cur_data_extract" {
  name          = "Cost and Usage Report 2.0"
  database_name = "curdatabase"
  table_prefix  = "cds_cur_export_crawler"
  role          = aws_iam_role.glue_crawler.arn
  s3_target {
    path = "s3://${data.aws_s3_bucket.cur_data_extract.id}/cds_/DailyCostExports/"
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

  //Schedule once a day when we want it updating.
  //schedule = "cron(0 8 * * * *)"

  tags = {
    Terraform = "true"
  }
}

resource "aws_iam_role" "glue_crawler" {
  name               = "AWSGlueServiceRole-cds_cur_extract_crawler"
  assume_role_policy = data.aws_iam_policy_document.glue.json
  path               = "/service-role/"
  tags = {
    Terraform = "true"
  }
}

data "aws_iam_policy_document" "glue" {
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
    resources = ["${data.aws_s3_bucket.cur_data_extract.arn}/cds_/DailyCostExports/*"]
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
