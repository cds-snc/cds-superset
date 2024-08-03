locals {
  data_export_role_arns = [
    aws_iam_role.data_export.arn,
    aws_iam_role.glue_crawler.arn,
    aws_iam_role.glue_etl.arn
  ]
  product_export_role_arns = [
    "arn:aws:iam::239043911459:role/DataExportSupersetReadSnaphots"
  ]
}

#
# KMS key used for all product data exports
#
resource "aws_kms_key" "data_export" {
  description         = "Encrypt objects in the data export S3 buckets"
  enable_key_rotation = "true"
  policy              = data.aws_iam_policy_document.data_export_kms.json
}

resource "aws_kms_alias" "data_export" {
  name          = "alias/data-export"
  target_key_id = aws_kms_key.data_export.key_id
}

data "aws_iam_policy_document" "data_export_kms" {
  # checkov:skip=CKV_AWS_109: false-positive,`resources = ["*"]` references KMS key policy is attached to
  # checkov:skip=CKV_AWS_111: false-positive,`resources = ["*"]` references KMS key policy is attached to

  # Allow this account to use the key
  statement {
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = [var.account_id]
    }
  }

  # Allow product accounts to use the key for encryption
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
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = concat(local.data_export_role_arns, local.product_export_role_arns)
    }
  }

  statement {
    sid    = "AllowS3Access"
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*"
    ]
    resources = ["*"]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}

#
# Role used by the data export
#
resource "aws_iam_role" "data_export" {
  name               = "DataExportSupersetReadSnaphots"
  assume_role_policy = data.aws_iam_policy_document.data_export_assume.json
  path               = "/service-role/"
  tags = {
    Terraform = "true"
  }
}

data "aws_iam_policy_document" "data_export_assume" {
  statement {
    principals {
      type = "Service"
      identifiers = [
        "export.rds.amazonaws.com",
      ]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "data_export" {
  policy_arn = aws_iam_policy.data_export.arn
  role       = aws_iam_role.data_export.name
}

resource "aws_iam_policy" "data_export" {
  name        = "DataExportSupersetReadSnaphots"
  policy      = data.aws_iam_policy_document.data_export.json
  description = "Used to assume into the product roles that will perform the RDS snapshot exports."
  path        = "/service-role/"
}

data "aws_iam_policy_document" "data_export" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = local.product_export_role_arns
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject*",
      "s3:ListBucket",
      "s3:GetObject*",
      "s3:DeleteObject*",
      "s3:GetBucketLocation"
    ]
    resources = [
      module.notify_data_export.s3_bucket_arn,
      "${module.notify_data_export.s3_bucket_arn}/*",
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

#
# Notify product data
#
module "notify_data_export" {
  source = "github.com/cds-snc/terraform-modules//S3?ref=v9.6.1"

  bucket_name = "${var.product_name}-notify-data-export"
  kms_key_arn = aws_kms_key.data_export.arn

  versioning = {
    enabled = true
  }

  billing_tag_value = var.billing_code
}

resource "aws_s3_bucket_policy" "notify_data_export" {
  bucket = module.notify_data_export.s3_bucket_id
  policy = data.aws_iam_policy_document.notify_data_export.json
}

data "aws_iam_policy_document" "notify_data_export" {
  statement {
    principals {
      type        = "AWS"
      identifiers = concat(local.data_export_role_arns, local.product_export_role_arns)
    }
    actions = [
      "s3:PutObject*",
      "s3:ListBucket",
      "s3:GetObject*",
      "s3:DeleteObject*",
      "s3:GetBucketLocation"
    ]
    resources = [
      module.notify_data_export.s3_bucket_arn,
      "${module.notify_data_export.s3_bucket_arn}/*",
    ]
  }
}
