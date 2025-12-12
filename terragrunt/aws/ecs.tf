locals {
  container_env_all = [
    {
      "name"  = "GUNICORN_KEEPALIVE"
      "value" = "120"
    },
    {
      "name"  = "SMTP_HOST"
      "value" = "email-smtp.${var.region}.amazonaws.com"
    },
    {
      "name"  = "SMTP_MAIL_FROM"
      "value" = "no-reply@${var.domain}"
    },
    {
      "name"  = "SUPERSET_DATABASE_DB"
      "value" = "superset"
    },
    {
      "name"  = "REDIS_HOST"
      "value" = split(":", aws_elasticache_replication_group.superset_cache.primary_endpoint_address)[0]
    },
    {
      "name"  = "REDIS_PORT"
      "value" = tostring(aws_elasticache_replication_group.superset_cache.port)
    },
    {
      "name"  = "CACHE_WARMUP_EXECUTORS"
      "value" = "cache-warmer"
    },
    {
      "name"  = "WEBDRIVER_BASEURL"
      "value" = "http://superset.superset.ecs.local:8088"
    },
    {
      "name"  = "WEBDRIVER_BASEURL_USER_FRIENDLY"
      "value" = "https://${var.domain}"
    },
    {
      "name"  = "FLASK_DEBUG"
      "value" = var.env == "staging" ? "true" : "false"
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
  container_env_opentelemetry = [
    {
      "name"  = "PYTHONPATH",
      "value" = "/otel-auto-instrumentation-python/opentelemetry/instrumentation/auto_instrumentation:/app:/otel-auto-instrumentation-python"
    },
    {
      "name"  = "OTEL_EXPORTER_OTLP_PROTOCOL",
      "value" = "http/protobuf"
    },
    {
      "name"  = "OTEL_TRACES_SAMPLER",
      "value" = "xray"
    },
    {
      "name"  = "OTEL_TRACES_SAMPLER_ARG",
      "value" = "endpoint=http://localhost:2000"
    },
    {
      "name"  = "OTEL_LOGS_EXPORTER",
      "value" = "none"
    },
    {
      "name"  = "OTEL_PYTHON_DISTRO",
      "value" = "aws_distro"
    },
    {
      "name"  = "OTEL_PYTHON_CONFIGURATOR",
      "value" = "aws_configurator"
    },
    {
      "name"  = "OTEL_EXPORTER_OTLP_TRACES_ENDPOINT",
      "value" = "http://localhost:4316/v1/traces"
    },
    {
      "name"  = "OTEL_AWS_APPLICATION_SIGNALS_EXPORTER_ENDPOINT",
      "value" = "http://localhost:4316/v1/metrics"
    },
    {
      "name"  = "OTEL_METRICS_EXPORTER",
      "value" = "none"
    },
    {
      "name"  = "OTEL_AWS_APPLICATION_SIGNALS_ENABLED",
      "value" = "true"
    }
  ]
  container_env_opentelemetry_celery_worker = [
    {
      "name"  = "OTEL_RESOURCE_ATTRIBUTES"
      "value" = "aws.log.group.names=/aws/ecs/superset/celery-worker,service.name=celery-worker"
    }
  ]
  container_env_opentelemetry_celery_beat = [
    {
      "name"  = "OTEL_RESOURCE_ATTRIBUTES"
      "value" = "aws.log.group.names=/aws/ecs/superset/celery-beat,service.name=celery-beat"
    }
  ]
  container_env_opentelemetry_superset = [
    {
      "name"  = "OTEL_RESOURCE_ATTRIBUTES"
      "value" = "aws.log.group.names=/aws/ecs/superset/superset,service.name=superset"
    }
  ]
  container_secrets_all = [
    {
      "name"      = "GUEST_TOKEN_JWT_SECRET"
      "valueFrom" = aws_ssm_parameter.guest_token_jwt_secret.arn
    },
    {
      "name"      = "SLACK_API_TOKEN"
      "valueFrom" = aws_ssm_parameter.slack_api_token.arn
    },
    {
      "name"      = "SMTP_USER"
      "valueFrom" = aws_ssm_parameter.smtp_user.arn
    },
    {
      "name"      = "SMTP_PASSWORD"
      "valueFrom" = aws_ssm_parameter.smtp_password.arn
    },
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
  cloudwatch_agent_container = jsonencode({
    name      = "ecs-cwagent"
    essential = true
    image     = "public.ecr.aws/cloudwatch-agent/cloudwatch-agent:1.300062.0b1304-arm64@sha256:9a790d0f904f15f284c03aaa2a5281244b5c4b71090577f342ed51d13a1eda22"
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-create-group  = "true"
        awslogs-region        = var.region
        awslogs-group         = "/ecs/ecs-cwagent"
        awslogs-stream-prefix = "ecs"
      }
    }
    secrets = [
      {
        name      = "CW_CONFIG_CONTENT"
        valueFrom = aws_ssm_parameter.ecs_cwagent_config.arn
      }
    ]
  })
  opentelemetry_init_container = jsonencode({
    name      = "init"
    essential = false
    image     = "public.ecr.aws/aws-observability/adot-autoinstrumentation-python:v0.14.0@sha256:cf4cdd456e0b56065f5def48e39a445fdf8a0af5e0bf7d0c1f7385149147c17d"
    command   = ["cp", "-a", "/autoinstrumentation/.", "/otel-auto-instrumentation-python"]
    mountPoints = [
      {
        sourceVolume  = "opentelemetry-auto-instrumentation"
        containerPath = "/otel-auto-instrumentation-python"
        readOnly      = false
      }
    ]
  })
}

module "superset_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.10.0"

  cluster_name     = "superset"
  service_name     = "superset"
  task_cpu         = 2048
  task_memory      = 6144
  cpu_architecture = "ARM64"

  service_use_latest_task_def    = true
  container_image_track_deployed = true

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
  container_environment               = setunion(local.container_env_all, local.container_env_google_auth, local.container_env_opentelemetry, local.container_env_opentelemetry_superset)
  container_secrets                   = setunion(local.container_secrets_all, local.container_secrets_google_auth)
  container_read_only_root_filesystem = false
  container_definitions               = [local.cloudwatch_agent_container, local.opentelemetry_init_container]
  container_depends_on = [{
    containerName = "init"
    condition     = "SUCCESS"
  }]
  container_mount_points = [{
    sourceVolume  = "opentelemetry-auto-instrumentation"
    containerPath = "/otel-auto-instrumentation-python"
    readOnly      = false
  }]

  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json,
    data.aws_iam_policy.cloudwatch_agent_server_policy.policy
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_assume_roles.json,
    data.aws_iam_policy.cloudwatch_agent_server_policy.policy
  ]
  task_volume = [{
    name = "opentelemetry-auto-instrumentation"
  }]

  # Networking
  lb_target_group_arn            = aws_lb_target_group.superset.arn
  subnet_ids                     = module.vpc.private_subnet_ids
  security_group_ids             = [aws_security_group.superset_ecs.id]
  service_discovery_enabled      = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.superset.id

  # Logging
  cloudwatch_log_group_retention_in_days = 365

  # Allow executing commands on the task
  enable_execute_command = false

  billing_tag_value = var.billing_code
}

module "celery_worker_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.10.0"

  create_cluster   = false
  cluster_name     = module.superset_ecs.cluster_name
  service_name     = "celery-worker"
  task_cpu         = 2048
  task_memory      = 6144
  cpu_architecture = "ARM64"

  service_use_latest_task_def    = true
  container_image_track_deployed = true

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
  container_environment               = setunion(local.container_env_all, local.container_env_opentelemetry, local.container_env_opentelemetry_celery_worker)
  container_secrets                   = local.container_secrets_all
  container_read_only_root_filesystem = false
  container_definitions               = [local.cloudwatch_agent_container, local.opentelemetry_init_container]
  container_depends_on = [{
    containerName = "init"
    condition     = "SUCCESS"
  }]
  container_mount_points = [{
    sourceVolume  = "opentelemetry-auto-instrumentation"
    containerPath = "/otel-auto-instrumentation-python"
    readOnly      = false
  }]

  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json,
    data.aws_iam_policy.cloudwatch_agent_server_policy.policy
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_assume_roles.json,
    data.aws_iam_policy.cloudwatch_agent_server_policy.policy
  ]
  task_volume = [{
    name = "opentelemetry-auto-instrumentation"
  }]

  # Networking
  subnet_ids                     = module.vpc.private_subnet_ids
  security_group_ids             = [aws_security_group.superset_ecs.id]
  service_discovery_enabled      = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.superset.id

  # Logging
  cloudwatch_log_group_retention_in_days = 365

  billing_tag_value = var.billing_code
}

module "celery_beat_ecs" {
  source = "github.com/cds-snc/terraform-modules//ecs?ref=v10.10.0"

  create_cluster   = false
  cluster_name     = module.superset_ecs.cluster_name
  service_name     = "celery-beat"
  task_cpu         = 512
  task_memory      = 1024
  cpu_architecture = "ARM64"

  service_use_latest_task_def    = true
  container_image_track_deployed = true

  # Scaling: this must always be 1 or scheduling errors will occur
  desired_count = 1

  # Task definition
  container_image                     = "${aws_ecr_repository.superset-image.repository_url}:latest"
  container_command                   = ["/app/docker/docker-bootstrap.sh", "beat"]
  container_host_port                 = 8088
  container_port                      = 8088
  container_environment               = setunion(local.container_env_all, local.container_env_opentelemetry, local.container_env_opentelemetry_celery_beat)
  container_secrets                   = local.container_secrets_all
  container_read_only_root_filesystem = false
  container_definitions               = [local.cloudwatch_agent_container, local.opentelemetry_init_container]
  container_depends_on = [{
    containerName = "init"
    condition     = "SUCCESS"
  }]
  container_mount_points = [{
    sourceVolume  = "opentelemetry-auto-instrumentation"
    containerPath = "/otel-auto-instrumentation-python"
    readOnly      = false
  }]

  task_exec_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_ssm_parameters.json,
    data.aws_iam_policy.cloudwatch_agent_server_policy.policy
  ]
  task_role_policy_documents = [
    data.aws_iam_policy_document.ecs_task_assume_roles.json,
    data.aws_iam_policy.cloudwatch_agent_server_policy.policy
  ]
  task_volume = [{
    name = "opentelemetry-auto-instrumentation"
  }]

  # Networking
  subnet_ids                     = module.vpc.private_subnet_ids
  security_group_ids             = [aws_security_group.superset_ecs.id]
  service_discovery_enabled      = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.superset.id

  # Logging
  cloudwatch_log_group_retention_in_days = 365

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
    cpu_architecture        = "ARM64"
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
      aws_ssm_parameter.ecs_cwagent_config.arn,
      aws_ssm_parameter.google_oauth_client_id.arn,
      aws_ssm_parameter.google_oauth_client_secret.arn,
      aws_ssm_parameter.guest_token_jwt_secret.arn,
      aws_ssm_parameter.slack_api_token.arn,
      aws_ssm_parameter.smtp_password.arn,
      aws_ssm_parameter.smtp_user.arn,
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

data "aws_iam_policy" "cloudwatch_agent_server_policy" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
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

resource "aws_ssm_parameter" "guest_token_jwt_secret" {
  name  = "guest_token_jwt_secret"
  type  = "SecureString"
  value = var.guest_token_jwt_secret
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "slack_api_token" {
  name  = "slack_api_token"
  type  = "SecureString"
  value = var.slack_api_token
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "smtp_password" {
  name  = "smtp_password"
  type  = "SecureString"
  value = var.smtp_password
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "smtp_user" {
  name  = "smtp_user"
  type  = "SecureString"
  value = var.smtp_user
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "superset_secret_key" {
  name  = "superset_secret_key"
  type  = "SecureString"
  value = var.superset_secret_key
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "ecs_cwagent_config" {
  name  = "ecs-cwagent"
  type  = "String"
  value = <<-EOT
    {
      "traces": {
        "traces_collected": {
          "application_signals": {}
        }
      },
      "logs": {
        "metrics_collected": {
          "application_signals": {}
        }
      }
    }
  EOT
  tags  = local.common_tags
}
