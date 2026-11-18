resource "aws_elasticache_replication_group" "superset_cache" {
  replication_group_id = "superset-cache-${var.env}"
  description          = "Valkey cache for Superset in ${var.env}"

  engine               = "valkey"
  engine_version       = "7.2"
  parameter_group_name = "default.valkey7"
  node_type            = var.env == "prod" ? "cache.t3.small" : "cache.t3.micro"
  num_cache_clusters   = 1
  port                 = 6379

  subnet_group_name = aws_elasticache_subnet_group.superset_cache.name
  security_group_ids = [
    aws_security_group.superset_redis.id,
  ]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  transit_encryption_mode    = "required"
  user_group_ids             = [aws_elasticache_user_group.superset_cache.user_group_id]

  apply_immediately = true

  tags = local.common_tags
}

resource "random_password" "superset_cache" {
  length  = 64
  special = false
}

resource "aws_ssm_parameter" "superset_cache_password" {
  name  = "superset_cache_password"
  type  = "SecureString"
  value = random_password.superset_cache.result
  tags  = local.core_tags
}

resource "aws_elasticache_user" "superset_cache" {
  user_id       = "superset-${var.env}"
  user_name     = "superset-${var.env}"
  engine        = "VALKEY"
  access_string = "on ~* &* +@all"

  authentication_mode {
    type      = "password"
    passwords = [random_password.superset_cache.result]
  }

  tags = local.common_tags
}

resource "aws_elasticache_user_group" "superset_cache" {
  user_group_id = "superset-cache-${var.env}"
  engine        = "VALKEY"
  user_ids      = [aws_elasticache_user.superset_cache.user_id]

  tags = local.common_tags
}

resource "aws_elasticache_subnet_group" "superset_cache" {
  name       = "superset-cache-${var.env}"
  subnet_ids = module.vpc.private_subnet_ids
}
