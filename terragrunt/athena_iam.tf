resource "aws_iam_role" "superset_athena_read" {
  name               = "SupersetAthenaRead"
  description        = "This role allows the Superset ECS task to read from Athena as a datasource"
  assume_role_policy = data.aws_iam_policy_document.superset_ecs_task_role.json

  tags = {
    Terraform = "true"
  }

  depends_on = [
    module.superset_ecs
  ]
}

data "aws_iam_policy_document" "superset_ecs_task_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.account_id}:role/superset_ecs_task_role",
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
    sid = "AthenaRead"
    actions = [
      "athena:BatchGetNamedQuery",
      "athena:BatchGetQueryExecution",
      "athena:GetNamedQuery",
      "athena:GetQueryExecution",
      "athena:GetQueryResults",
      "athena:GetQueryResultsStream",
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
    sid = "S3AthenaSourceBucketRead"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      data.aws_s3_bucket.cur_data_extract.arn,
      "${data.aws_s3_bucket.cur_data_extract.arn}/*"
    ]
  }

  statement {
    sid = "S3AthenaResultBucketWrite"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:AbortMultipartUpload",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]
    resources = [
      data.aws_s3_bucket.cur_data_extract_queries.arn,
      "${data.aws_s3_bucket.cur_data_extract_queries.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "superset_athena_read" {
  policy_arn = aws_iam_policy.superset_athena_read.arn
  role       = aws_iam_role.superset_athena_read.name
}
