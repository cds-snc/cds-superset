locals {
  prefix = "cds"
  common_tags = {
    Terraform  = "true",
    CostCentre = var.billing_code,
  }
}

module "vpc" {

  source = "github.com/cds-snc/terraform-modules//vpc?ref=v9.0.0"
  name   = "superspace-${var.env}"

  enable_flow_log                  = true
  availability_zones               = 2
  cidrsubnet_newbits               = 8
  single_nat_gateway               = true
  allow_https_request_out          = true
  allow_https_request_out_response = true
  allow_https_request_in           = true
  allow_https_request_in_response  = true

  billing_tag_value = var.billing_code
}

module "superset-redis" {
  source               = "../modules/aws/redis"
  prefix               = local.prefix
  common_tags          = local.common_tags
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  node_type            = var.node_type
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = 6379
  # allowed_security_groups = {
  #   "worker"      = module.superset-core.ecs_service_security_group_id
  #   "app"         = module.superset-core.app_service_security_group_id
  #   "worker_beat" = module.superset-core.worker_beat_service_security_group_id
  # }
}

resource "aws_ecs_cluster" "superset" {
  name = "superset"

  tags = {
    "Terraform" = "true"
  }
  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}

resource "aws_cloudwatch_log_group" "superset" {
  name              = "/ecs/superset"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "superset_image" {

  family       = "superset-image"
  cpu          = 1024
  memory       = 8192
  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.superset_task_execution_role.arn
  task_role_arn            = aws_iam_role.superset_task_role.arn
  container_definitions    = data.template_file.superset-image.rendered

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

data "template_file" "superset-image" {
  template = file("task_definitions/superset.tmpl.json")

  vars = {
    AWS_LOGS_GROUP         = aws_cloudwatch_log_group.superset.name
    AWS_LOGS_REGION        = var.region
    AWS_LOGS_STREAM_PREFIX = "task"
    SUPERSET_IMAGE         = "apache/superset:latest"
    SUPERSET_SECRET_KEY    = "foo" # TODO: generate it and store it as a secret
  }
}


resource "aws_security_group" "superset_ecs" {
  description = "NSG for Superset ECS Tasks"
  name        = "superset_ecs"

  tags = {
    Name       = "superset_ecs"
    Terraform  = "true"
    CostCentre = var.billing_code

  }
}

resource "aws_security_group_rule" "allow_all" {
  type = "egress"

  protocol = "-1"

  to_port   = 0
  from_port = 0

  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.superset_ecs.id
}

import {
  to = aws_security_group_rule.allow_all
  id = "sg-038e16631d49d3f69_egress_all_0_0_0.0.0.0/0"
}

import {
  to = aws_security_group.superset_ecs
  id = "sg-038e16631d49d3f69"
}

resource "aws_ecs_service" "superset_image" {
  name = "superset"

  desired_count  = 1
  propagate_tags = "SERVICE"

  capacity_provider_strategy {
    base              = 0
    capacity_provider = "FARGATE"
    weight            = 1
  }
  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }

  deployment_controller {
    type = "ECS"
  }

  task_definition = aws_ecs_task_definition.superset_image.arn

  network_configuration {
    subnets          = module.vpc.private_subnet_ids
    security_groups  = [aws_security_group.superset_ecs.id]
    assign_public_ip = false

  }
}

import {
  to = aws_ecs_service.superset_image
  id = "superset/superset"
}