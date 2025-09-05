resource "aws_elasticache_replication_group" "superset_cache" {
  replication_group_id = "superset-cache-${var.env}"
  description          = "Valkey cache for Superset in ${var.env}"

  engine               = "valkey"
  engine_version       = "7.2"
  parameter_group_name = "default.valkey7"
  node_type            = var.env == "prod" ? "cache.t2.small" : "cache.t2.micro"
  num_cache_clusters   = 1
  port                 = 6379

  subnet_group_name = aws_elasticache_subnet_group.superset_cache.name
  security_group_ids = [
    aws_security_group.superset_redis.id,
  ]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true

  tags = local.common_tags
}

resource "aws_elasticache_subnet_group" "superset_cache" {
  name       = "superset-cache-${var.env}"
  subnet_ids = module.vpc.private_subnet_ids
}
