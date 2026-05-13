locals {
  docker_push_role   = "${var.product_name}-docker-push"
  docker_deploy_role = "${var.product_name}-docker-deploy"
}

module "github_workflow_roles" {
  source = "github.com/cds-snc/terraform-modules//gh_oidc_role?ref=v10.11.4"

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
    }
  ]

  oidc_exists       = true
  billing_tag_value = var.billing_code
}

#
# Docker push role — used by docker-apply-staging and docker-apply-prod workflows
#

resource "aws_iam_role_policy_attachment" "docker_push" {
  role       = local.docker_push_role
  policy_arn = aws_iam_policy.docker_push.arn

  depends_on = [module.github_workflow_roles]
}

resource "aws_iam_policy" "docker_push" {
  name   = local.docker_push_role
  path   = "/"
  policy = data.aws_iam_policy_document.docker_push.json
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

#
# Docker deploy role — used by docker-deploy-staging and docker-deploy-prod workflows
#

resource "aws_iam_role_policy_attachment" "docker_deploy" {
  role       = local.docker_deploy_role
  policy_arn = aws_iam_policy.docker_deploy.arn

  depends_on = [module.github_workflow_roles]
}

resource "aws_iam_policy" "docker_deploy" {
  name   = local.docker_deploy_role
  path   = "/"
  policy = data.aws_iam_policy_document.docker_deploy.json
}

data "aws_iam_policy_document" "docker_deploy" {
  #trivy:ignore:AVD-AWS-0342
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeServices",
      "ecs:DescribeTasks",
      "ecs:RunTask",
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
      "iam:PassRole",
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/superset*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
    ]
    resources = [
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/ecs/superset/*/container-image",
    ]
  }
}
