locals {
  container_environment = [
    {
      "name"  = "SUPERSET_DATABASE_DB"
      "value" = "superset"
    },
  ]
  container_secrets = [
    {
      "name"      = "SUPERSET_DATABASE_HOST"
      "valueFrom" = aws_ssm_parameter.superset_database_host.arn
    },
    {
      "name"      = "SUPERSET_DATABASE_USER"
      "valueFrom" = aws_ssm_parameter.superset_database_username.arn
    },
    {
      "name"      = "SUPERSET_DATABASE_PASSWORD"
      "valueFrom" = aws_ssm_parameter.superset_database_password.arn
    },
    {
      "name"      = "SUPERSET_SECRET_KEY"
      "valueFrom" = aws_ssm_parameter.superset_secret_key.arn
    },
  ]
}

module "superset_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v9.0.4"

  cluster_name  = "superset"
  service_name  = "superset"
  task_cpu      = 1024
  task_memory   = 8192
  desired_count = 1

  enable_execute_command = true

  # Task definition
  container_image                     = "${aws_ecr_repository.superset-image.repository_url}:latest"
  container_host_port                 = 8088
  container_port                      = 8088
  container_environment               = local.container_environment
  container_secrets                   = local.container_secrets
  container_read_only_root_filesystem = false

  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_create_tunnel.json
  ]

  # Networking
  lb_target_group_arn = aws_lb_target_group.superset.arn
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [aws_security_group.superset_ecs.id]

  billing_tag_value = var.billing_code
}

data "aws_iam_policy_document" "ecs_task_ssm_parameters" {
  statement {
    sid    = "GetWeblateSSMParameters"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
    ]
    resources = [
      aws_ssm_parameter.superset_secret_key.arn,
      aws_ssm_parameter.superset_database_host.arn,
      aws_ssm_parameter.superset_database_username.arn,
      aws_ssm_parameter.superset_database_password.arn,
    ]
  }
}

data "aws_iam_policy_document" "ecs_task_create_tunnel" {
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

resource "aws_ssm_parameter" "superset_secret_key" {
  name  = "superset_secret_key"
  type  = "SecureString"
  value = var.superset_secret_key
  tags  = local.common_tags
}