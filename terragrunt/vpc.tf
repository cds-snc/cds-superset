locals {
  prefix = "cds"
  common_tags = {
    Terraform  = "true"
    CostCentre = var.billing_code
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

resource "aws_security_group" "superset_ecs" {
  description = "NSG for Superset ECS Tasks"
  name        = "superset_ecs"

  tags = merge(
    local.common_tags,
    {
      Name = "superset_ecs"
    }
  )
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  protocol          = "-1"
  to_port           = 0
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.superset_ecs.id
}
