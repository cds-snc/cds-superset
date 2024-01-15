resource "aws_route53_zone" "superset" {
  name = var.domain
  tags = local.common_tags
}

resource "aws_route53_record" "superset_A" {
  zone_id = aws_route53_zone.superset.zone_id
  name    = var.domain
  type    = "A"

  alias {
    name                   = aws_lb.superset.dns_name
    zone_id                = aws_lb.superset.zone_id
    evaluate_target_health = false
  }
}
