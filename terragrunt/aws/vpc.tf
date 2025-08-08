locals {
  prefix = "cds"
  common_tags = {
    Terraform  = "true"
    CostCentre = var.billing_code
  }
}

module "vpc" {
  source = "github.com/cds-snc/terraform-modules//vpc?ref=v10.6.2"
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

resource "aws_service_discovery_private_dns_namespace" "superset" {
  name        = "superset.ecs.local"
  description = "DNS namespace used to provide service discovery for the Superset ECS services (application and Celery workers)"
  vpc         = module.vpc.vpc_id
  tags        = local.common_tags
}

resource "aws_network_acl_rule" "smtp_ssl_ingress" {
  network_acl_id = module.vpc.main_nacl_id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 587
  to_port        = 587
}

resource "aws_network_acl_rule" "smtp_ssl_egress" {
  network_acl_id = module.vpc.main_nacl_id
  rule_number    = 110
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 587
  to_port        = 587
}

#
# Security groups
#

# ECS
resource "aws_security_group" "superset_ecs" {
  description = "NSG for Superset ECS Tasks"
  name        = "superset_ecs"
  vpc_id      = module.vpc.vpc_id
  tags        = local.common_tags
}

resource "aws_security_group_rule" "superset_ecs_egress_all" {
  type              = "egress"
  protocol          = "-1"
  to_port           = 0
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.superset_ecs.id
}

resource "aws_security_group_rule" "superset_ecs_ingress_lb" {
  description              = "Ingress from load balancer to Superset ECS task"
  type                     = "ingress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  security_group_id        = aws_security_group.superset_ecs.id
  source_security_group_id = aws_security_group.superset_lb.id
}

resource "aws_security_group_rule" "superset_ecs_ingress_self" {
  description       = "Ingress from Superset ECS task to itself"
  type              = "ingress"
  from_port         = 8088
  to_port           = 8088
  protocol          = "tcp"
  security_group_id = aws_security_group.superset_ecs.id
  self              = true
}

# Load balancer
resource "aws_security_group" "superset_lb" {
  name        = "superset_lb"
  description = "NSG for Superset load balancer"
  vpc_id      = module.vpc.vpc_id
  tags        = local.common_tags
}

resource "aws_security_group_rule" "superset_lb_ingress_internet_https" {
  description       = "Ingress from internet to load balancer (HTTPS)"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.superset_lb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "superset_lb_egress_ecs" {
  description              = "Egress from load balancer to Superset ECS task"
  type                     = "egress"
  from_port                = 8088
  to_port                  = 8088
  protocol                 = "tcp"
  security_group_id        = aws_security_group.superset_lb.id
  source_security_group_id = aws_security_group.superset_ecs.id
}

# Database
resource "aws_security_group" "superset_db" {
  name        = "superset_db"
  description = "NSG for Superset database"
  vpc_id      = module.vpc.vpc_id
  tags        = local.common_tags
}

resource "aws_security_group_rule" "superset_db_ingress_ecs" {
  description              = "Ingress from Superset ECS task to database"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.superset_db.id
  source_security_group_id = aws_security_group.superset_ecs.id
}

# Redis
resource "aws_security_group" "superset_redis" {
  name        = "${local.prefix}-redis-sg"
  description = "Default redis security group"
  vpc_id      = module.vpc.vpc_id
  tags        = local.common_tags
}

resource "aws_security_group_rule" "superset_redis_ingress_ecs" {
  description              = "Ingress from Superset ECS task to redis"
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.superset_redis.id
  source_security_group_id = aws_security_group.superset_ecs.id
}
