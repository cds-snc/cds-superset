locals {
  container_secrets = [
    {
      "name"      = "SUPERSET_SECRET_KEY",
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

  # Task definition
  container_image                     = "${aws_ecr_repository.superset-image.repository_url}:latest"
  container_host_port                 = 8088
  container_port                      = 8088
  container_secrets                   = local.container_secrets
  container_read_only_root_filesystem = false

  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ssm_parameters.json
  ]

  # Networking
  lb_target_group_arn = aws_lb_target_group.superset.arn
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [aws_security_group.superset_ecs.id]

  billing_tag_value = var.billing_code
}

data "aws_iam_policy_document" "ssm_parameters" {
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

resource "aws_ssm_parameter" "superset_secret_key" {
  name  = "superset_secret_key"
  type  = "SecureString"
  value = var.superset_secret_key
  tags  = local.common_tags
}
