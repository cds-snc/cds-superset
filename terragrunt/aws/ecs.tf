locals {
  container_env_all = [
    {
      "name"  = "GUNICORN_KEEPALIVE"
      "value" = "120"
    },
    {
      "name"  = "SUPERSET_DATABASE_DB"
      "value" = "superset"
    },
    {
      "name"  = "REDIS_HOST"
      "value" = aws_elasticache_cluster.superset.cache_nodes[0]["address"]
    },
    {
      "name"  = "REDIS_PORT"
      "value" = tostring(aws_elasticache_cluster.superset.port)
    },
    {
      "name"  = "THUMBNAIL_SELENIUM_USER"
      "value" = "cache-warmer"
    },
    {
      "name"  = "WEBDRIVER_BASEURL"
      "value" = "https://${var.domain}"
    }
  ]
  container_env_google_auth = [
    {
      "name"  = "GOOGLE_AUTH_DOMAIN"
      "value" = var.domain
    },
    {
      "name"  = "GOOGLE_OAUTH_EMAIL_DOMAIN"
      "value" = "cds-snc.ca"
    },
    {
      "name"  = "GOOGLE_OAUTH_LOGIN"
      "value" = "true"
    }
  ]
  container_secrets_all = [
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
  container_secrets_google_auth = [
    {
      "name"      = "GOOGLE_OAUTH_CLIENT_ID"
      "valueFrom" = aws_ssm_parameter.google_oauth_client_id.arn
    },
    {
      "name"      = "GOOGLE_OAUTH_CLIENT_SECRET"
      "valueFrom" = aws_ssm_parameter.google_oauth_client_secret.arn
    },
  ]
}

module "superset_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.4.1"

  cluster_name     = "superset"
  service_name     = "superset"
  task_cpu         = 2048
  task_memory      = 4096
  cpu_architecture = "ARM64"

  service_use_latest_task_def = true

  # Scaling
  enable_autoscaling       = true
  desired_count            = 1
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 2

  # Task definition
  container_image                     = "${aws_ecr_repository.superset-image.repository_url}:latest"
  container_command                   = ["/app/docker/docker-bootstrap.sh", "app"]
  container_host_port                 = 8088
  container_port                      = 8088
  container_environment               = setunion(local.container_env_all, local.container_env_google_auth)
  container_secrets                   = setunion(local.container_secrets_all, local.container_secrets_google_auth)
  container_read_only_root_filesystem = false
  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_assume_roles.json
  ]

  # Networking
  lb_target_group_arn            = aws_lb_target_group.superset.arn
  subnet_ids                     = module.vpc.private_subnet_ids
  security_group_ids             = [aws_security_group.superset_ecs.id]
  service_discovery_enabled      = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.superset.id

  # Allow executing commands on the task
  enable_execute_command = false

  billing_tag_value = var.billing_code
}

module "celery_worker_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.4.1"

  create_cluster   = false
  cluster_name     = module.superset_ecs.cluster_name
  service_name     = "celery-worker"
  task_cpu         = 2048
  task_memory      = 4096
  cpu_architecture = "ARM64"

  service_use_latest_task_def = true

  # Scaling
  enable_autoscaling       = true
  desired_count            = 1
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 2

  # Task definition
  container_image                     = "${aws_ecr_repository.superset-image.repository_url}:latest"
  container_command                   = ["/app/docker/docker-bootstrap.sh", "worker"]
  container_host_port                 = 8088
  container_port                      = 8088
  container_environment               = local.container_env_all
  container_secrets                   = local.container_secrets_all
  container_read_only_root_filesystem = false
  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_assume_roles.json
  ]

  # Networking
  subnet_ids                     = module.vpc.private_subnet_ids
  security_group_ids             = [aws_security_group.superset_ecs.id]
  service_discovery_enabled      = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.superset.id

  billing_tag_value = var.billing_code
}

module "celery_beat_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.4.1"

  create_cluster   = false
  cluster_name     = module.superset_ecs.cluster_name
  service_name     = "celery-beat"
  task_cpu         = 512
  task_memory      = 1024
  cpu_architecture = "ARM64"

  service_use_latest_task_def = true

  # Scaling: this must always be 1 or scheduling errors will occur
  desired_count = 1

  # Task definition
  container_image                     = "${aws_ecr_repository.superset-image.repository_url}:latest"
  container_command                   = ["/app/docker/docker-bootstrap.sh", "beat"]
  container_host_port                 = 8088
  container_port                      = 8088
  container_environment               = local.container_env_all
  container_secrets                   = local.container_secrets_all
  container_read_only_root_filesystem = false
  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_assume_roles.json
  ]

  # Networking
  subnet_ids                     = module.vpc.private_subnet_ids
  security_group_ids             = [aws_security_group.superset_ecs.id]
  service_discovery_enabled      = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.superset.id

  billing_tag_value = var.billing_code
}

# Create an ECS task that runs database upgrades
resource "aws_ecs_task_definition" "superset_upgrade" {
  family             = "superset-upgrade"
  cpu                = 1024
  memory             = 2048
  execution_role_arn = module.superset_ecs.task_exec_role_arn
  task_role_arn      = module.superset_ecs.task_role_arn
  container_definitions = jsonencode([{
    name      = "superset-upgrade"
    cpu       = 1024
    memory    = 2048
    essential = true
    command   = ["/app/docker/docker-bootstrap.sh", "upgrade"]
    image     = "${aws_ecr_repository.superset-image.repository_url}:latest"
    linuxParameters = {
      capabilities : {
        add : [],
        drop : ["ALL"]
      }
    }
    portMappings = [{
      hostPort : 8088,
      containerPort : 8088,
      protocol : "tcp"
    }]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-region        = var.region,
        awslogs-group         = module.superset_ecs.cloudwatch_log_group_name,
        awslogs-stream-prefix = "upgrade"
      }
    }
    mountPoints    = []
    systemControls = []
    volumesFrom    = []
    environment    = local.container_env_all
    secrets        = local.container_secrets_all
  }])
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  tags = local.common_tags
}


#
# IAM policies
#
data "aws_iam_policy_document" "ecs_task_ssm_parameters" {
  statement {
    sid    = "GetSSMParameters"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
    ]
    resources = [
      aws_ssm_parameter.google_oauth_client_id.arn,
      aws_ssm_parameter.google_oauth_client_secret.arn,
      aws_ssm_parameter.superset_secret_key.arn,
      aws_ssm_parameter.superset_database_host.arn,
      aws_ssm_parameter.superset_database_username.arn,
      aws_ssm_parameter.superset_database_password.arn,
    ]
  }
}

data "aws_iam_policy_document" "ecs_task_assume_roles" {
  statement {
    sid    = "AssumeRoles"
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::${var.account_id}:role/SupersetAthenaRead"
    ]
  }
}

data "aws_iam_policy_document" "ecs_task_create_tunnel" {
  statement {
    sid    = "CreateSSMTunnel"
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

#
# SSM parameters
#
resource "aws_ssm_parameter" "google_oauth_client_id" {
  name  = "google_oauth_client_id"
  type  = "SecureString"
  value = var.google_oauth_client_id
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "google_oauth_client_secret" {
  name  = "google_oauth_client_secret"
  type  = "SecureString"
  value = var.google_oauth_client_secret
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "superset_secret_key" {
  name  = "superset_secret_key"
  type  = "SecureString"
  value = var.superset_secret_key
  tags  = local.common_tags
}
