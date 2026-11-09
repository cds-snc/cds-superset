locals {
  docker_push_role   = "${var.product_name}-docker-push"
  docker_deploy_role = "${var.product_name}-docker-deploy"
  docker_pull        = "${var.product_name}-docker-pull"
}

module "github_workflow_roles" {
  source = "github.com/cds-snc/terraform-modules//gh_oidc_role?ref=v13.3.0"

  roles = [
    {
      name      = local.docker_push_role
      repo_name = "cds-superset"
      claim     = "ref:refs/heads/main"
    },
    {
      name      = local.docker_deploy_role
      repo_name = "cds-superset"
      claim     = "ref:refs/heads/main"
    },
    {
      name      = local.docker_pull
      repo_name = "cds-superset"
      claim     = "ref:refs/heads/main"
    }
  ]
  oidc_exists       = true
  billing_tag_value = var.billing_code
}

resource "aws_iam_role_policy_attachment" "docker_push" {
  role       = local.docker_push_role
  policy_arn = aws_iam_policy.docker_push.arn

  depends_on = [module.github_workflow_roles]
}

resource "aws_iam_policy" "docker_push" {
  name   = local.docker_push_role
  path   = "/"
  policy = data.aws_iam_policy_document.docker_push.json
  tags   = local.core_tags
}

#trivy:ignore:AVD-AWS-0342
data "aws_iam_policy_document" "docker_push" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart",
    ]
    resources = [aws_ecr_repository.superset-image.arn]
  }
}

resource "aws_iam_role_policy_attachment" "docker_deploy" {
  role       = local.docker_deploy_role
  policy_arn = aws_iam_policy.docker_deploy.arn

  depends_on = [module.github_workflow_roles]
}

resource "aws_iam_policy" "docker_deploy" {
  name   = local.docker_deploy_role
  path   = "/"
  policy = data.aws_iam_policy_document.docker_deploy.json
  tags   = local.core_tags
}

#trivy:ignore:AVD-AWS-0342
data "aws_iam_policy_document" "docker_deploy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
      "ecs:TagResource",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:UpdateService",
    ]
    resources = [
      "arn:aws:ecs:${var.region}:${var.account_id}:cluster/superset",
      "arn:aws:ecs:${var.region}:${var.account_id}:service/superset/*",
      "arn:aws:ecs:${var.region}:${var.account_id}:task/superset/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:RunTask",
    ]
    resources = [
      "arn:aws:ecs:${var.region}:${var.account_id}:task-definition/superset-upgrade:*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole",
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/superset_ecs_task_exec_role",
      "arn:aws:iam::${var.account_id}:role/superset_ecs_task_role",
      "arn:aws:iam::${var.account_id}:role/celery-worker_ecs_task_exec_role",
      "arn:aws:iam::${var.account_id}:role/celery-worker_ecs_task_role",
      "arn:aws:iam::${var.account_id}:role/celery-beat_ecs_task_exec_role",
      "arn:aws:iam::${var.account_id}:role/celery-beat_ecs_task_role",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
    ]
    resources = [
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/ecs/superset/superset/container-image",
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/ecs/superset/celery-worker/container-image",
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/ecs/superset/celery-beat/container-image",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "docker_pull" {
  role       = local.docker_pull
  policy_arn = aws_iam_policy.docker_pull.arn

  depends_on = [module.github_workflow_roles]
}

resource "aws_iam_policy" "docker_pull" {
  name   = local.docker_pull
  path   = "/"
  policy = data.aws_iam_policy_document.docker_pull.json
  tags   = local.core_tags
}

data "aws_iam_policy_document" "docker_pull" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:BatchImportUpstreamImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    resources = [
      "arn:aws:ecr:${var.region}:${var.account_id}:repository/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
}