locals {
  data_lake_account_id = "739275439843"
  data_lake_region     = "ca-central-1"

  data_lake_athena_bucket_arn      = "arn:aws:s3:::cds-data-lake-athena-production"
  data_lake_curated_bucket_arn     = "arn:aws:s3:::cds-data-lake-curated-production"
  data_lake_transformed_bucket_arn = "arn:aws:s3:::cds-data-lake-transformed-production"

  glue_base_access = [
    aws_athena_data_catalog.data_lake.arn,
    "arn:aws:glue:${local.data_lake_region}:${local.data_lake_account_id}:catalog",
    "arn:aws:glue:${local.data_lake_region}:${local.data_lake_account_id}:database/operations_aws_production",
    "arn:aws:glue:${local.data_lake_region}:${local.data_lake_account_id}:table/operations_aws_production/*"
  ] 
  glue_staging_access = [
    "arn:aws:glue:${local.data_lake_region}:${local.data_lake_account_id}:database/platform_gc_forms_production",
    "arn:aws:glue:${local.data_lake_region}:${local.data_lake_account_id}:table/platform_gc_forms_production/*",
  ]
  glue_access = concat(local.glue_base_access, (var.env == "staging" ? local.glue_staging_access : []))
}

resource "aws_iam_role" "superset_athena_read" {
  name               = "SupersetAthenaRead"
  description        = "This role allows the Superset ECS task to read from Athena as a datasource"
  assume_role_policy = data.aws_iam_policy_document.superset_ecs_task_role.json

  tags = {
    Terraform = "true"
  }
}

data "aws_iam_policy_document" "superset_ecs_task_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        module.superset_ecs.task_role_arn
      ]
    }
  }
}

resource "aws_iam_policy" "superset_athena_read" {
  name   = "SupersetAthenaRead"
  policy = data.aws_iam_policy_document.superset_athena_read.json

  tags = {
    Terraform = "true"
  }
}

data "aws_iam_policy_document" "superset_athena_read" {
  statement {
    sid    = "AthenaDataCatalogAccess"
    effect = "Allow"
    actions = [
      "athena:GetDataCatalog"
    ]
    resources = [
      aws_athena_data_catalog.data_lake.arn
    ]
  }

  statement {
    sid    = "AthenaRead"
    effect = "Allow"
    actions = [
      "athena:BatchGetNamedQuery",
      "athena:BatchGetQueryExecution",
      "athena:GetNamedQuery",
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:GetQueryResultsStream",
      "athena:GetTableMetadata",
      "athena:GetWorkGroup",
      "athena:ListDatabases",
      "athena:ListDataCatalogs",
      "athena:ListNamedQueries",
      "athena:ListQueryExecutions",
      "athena:ListTagsForResource",
      "athena:ListWorkGroups",
      "athena:ListTableMetadata",
      "athena:StartQueryExecution",
      "athena:StopQueryExecution",
      "athena:CreatePreparedStatement",
      "athena:DeletePreparedStatement",
      "athena:GetPreparedStatement"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "GlueRead"
    effect = "Allow"
    actions = [
      "glue:BatchGetPartition",
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetPartition",
      "glue:GetPartitions",
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetTableVersion",
      "glue:GetTableVersions"
    ]
    resources = local.glue_access
  }

  statement {
    sid    = "S3AthenaSourceBucketRead"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      local.data_lake_curated_bucket_arn,
      "${local.data_lake_curated_bucket_arn}/*",
      local.data_lake_transformed_bucket_arn,
      "${local.data_lake_transformed_bucket_arn}/*",
    ]
  }

  statement {
    sid    = "S3AthenaResultBucketWrite"
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:AbortMultipartUpload",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      local.data_lake_athena_bucket_arn,
      "${local.data_lake_athena_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "superset_athena_read" {
  policy_arn = aws_iam_policy.superset_athena_read.arn
  role       = aws_iam_role.superset_athena_read.name
}
