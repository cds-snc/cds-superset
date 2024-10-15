resource "aws_lb" "superset" {
  name               = "superset-${var.env}"
  internal           = false
  load_balancer_type = "application"

  drop_invalid_header_fields = true
  enable_deletion_protection = true

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
    type = "lb_cookie"
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
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-FIPS-2023-04"
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

resource "aws_lb_listener" "superset_http_redirect" {
  load_balancer_arn = aws_lb.superset.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = local.common_tags
}
