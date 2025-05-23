locals {
  data_lake_athena_bucket_arn_prefix      = "arn:aws:s3:::cds-data-lake-athena"
  data_lake_curated_bucket_arn_prefix     = "arn:aws:s3:::cds-data-lake-curated"
  data_lake_transformed_bucket_arn_prefix = "arn:aws:s3:::cds-data-lake-transformed"
}

resource "aws_iam_role" "superset_athena_read" {
  for_each = toset(var.glue_databases)

  name               = "SupersetAthenaRead-${each.key}"
  description        = "This role allows the Superset ECS task and Celery workers to read from the ${each.key} Glue database"
  assume_role_policy = data.aws_iam_policy_document.superset_ecs_task_role.json

  tags = local.common_tags
}

data "aws_iam_policy_document" "superset_ecs_task_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        module.superset_ecs.task_role_arn,
        module.celery_worker_ecs.task_role_arn,
      ]
    }
  }
}

resource "aws_iam_policy" "superset_athena_read" {
  for_each = toset(var.glue_databases)

  name   = "SupersetAthenaRead-${each.key}"
  policy = data.aws_iam_policy_document.superset_athena_read_combined[each.key].json

  tags = local.common_tags
}

data "aws_iam_policy_document" "superset_athena_read_combined" {
  for_each = toset(var.glue_databases)

  source_policy_documents = [
    data.aws_iam_policy_document.superset_athena_read.json,
    data.aws_iam_policy_document.glue_database[each.key].json
  ]
}

data "aws_iam_policy_document" "superset_athena_read" {
  statement {
    sid    = "AthenaDataCatalogAccess"
    effect = "Allow"
    actions = [
      "athena:GetDataCatalog"
    ]
    resources = [
      for account in var.data_lake_account_access :
      aws_athena_data_catalog.data_lake[account.env_name].arn
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
    sid    = "S3AthenaSourceBucketRead"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = flatten([
      for account in var.data_lake_account_access : [
        "${local.data_lake_curated_bucket_arn_prefix}-${account.env_name}",
        "${local.data_lake_curated_bucket_arn_prefix}-${account.env_name}/*",
        "${local.data_lake_transformed_bucket_arn_prefix}-${account.env_name}",
        "${local.data_lake_transformed_bucket_arn_prefix}-${account.env_name}/*",
      ]
    ])
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
    resources = flatten([
      for account in var.data_lake_account_access : [
        "${local.data_lake_athena_bucket_arn_prefix}-${account.env_name}",
        "${local.data_lake_athena_bucket_arn_prefix}-${account.env_name}/*",
      ]
    ])
  }
}

data "aws_iam_policy_document" "glue_database" {
  for_each = toset(var.glue_databases)

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
    resources = flatten([
      for account in var.data_lake_account_access :
      # Only include the Glue database resources if they are part of the same account environment
      each.key == "all" || endswith(each.key, account.env_name) ? [
        aws_athena_data_catalog.data_lake[account.env_name].arn,
        "arn:aws:glue:${var.region}:${account.account_id}:catalog",
        "arn:aws:glue:${var.region}:${account.account_id}:database/${each.key == "all" ? "*" : each.key}",
        "arn:aws:glue:${var.region}:${account.account_id}:table/${each.key == "all" ? "*" : each.key}/*"
      ] : []
    ])
  }
}

resource "aws_iam_role_policy_attachment" "superset_athena_read" {
  for_each = toset(var.glue_databases)

  policy_arn = aws_iam_policy.superset_athena_read[each.key].arn
  role       = aws_iam_role.superset_athena_read[each.key].name
}
