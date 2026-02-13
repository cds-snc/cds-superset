resource "aws_lb" "superset" {
  name               = "superset-${var.env}"
  internal           = false
  load_balancer_type = "application"

  drop_invalid_header_fields = true
  enable_deletion_protection = true

  access_logs {
    bucket  = var.cbs_satellite_bucket_name
    prefix  = "lb_logs"
    enabled = true
  }

  security_groups = [
    aws_security_group.superset_lb.id
  ]
  subnets = module.vpc.public_subnet_ids

  tags = local.common_tags
}

resource "random_string" "alb_tg_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_lb_target_group" "superset" {
  name                 = "superset-tg-${random_string.alb_tg_suffix.result}"
  port                 = 8088
  protocol             = "HTTP"
  target_type          = "ip"
  deregistration_delay = 30
  vpc_id               = module.vpc.vpc_id

  health_check {
    enabled  = true
    protocol = "HTTP"
    path     = "/"
    matcher  = "200-399"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = 43200 # 12 hours
  }

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      stickiness[0].cookie_name
    ]
  }
}

resource "aws_lb_listener" "superset" {
  load_balancer_arn = aws_lb.superset.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-FIPS-2023-04"
  certificate_arn   = aws_acm_certificate.superset.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.superset.arn
  }

  depends_on = [
    aws_acm_certificate_validation.superset,
    aws_route53_record.superset_validation,
  ]

  tags = local.common_tags
}

# Serve security.txt as a fixed response from the ALB
resource "aws_alb_listener_rule" "security_txt" {
  listener_arn = aws_lb_listener.superset.arn
  priority     = 100

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = var.security_txt_content
      status_code  = "200"
    }
  }

  condition {
    path_pattern {
      values = ["/.well-known/security.txt"]
    }
  }

  tags = local.common_tags
}