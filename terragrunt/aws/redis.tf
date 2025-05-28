resource "aws_elasticache_cluster" "superset" {
  cluster_id           = join("-", [local.prefix, "redis"])
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.superset.name

  security_group_ids = [
    aws_security_group.superset_redis.id,
  ]

  tags = local.common_tags
}

resource "aws_elasticache_subnet_group" "superset" {
  name       = join("-", [local.prefix, "redis-subnet-grp"])
  subnet_ids = module.vpc.private_subnet_ids
}

resource "aws_elasticache_cluster" "superset_cache" {
  cluster_id           = "superset-cache-${var.env}"
  engine               = "valkey"
  node_type            = var.env == "prod" ? "cache.t2.small" : "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.valkey7"
  engine_version       = "7"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.superset_cache.name

  security_group_ids = [
    aws_security_group.superset_redis.id,
  ]

  tags = local.common_tags
}

resource "aws_elasticache_subnet_group" "superset_cache" {
  name       = "superset-cache-${var.env}"
  subnet_ids = module.vpc.private_subnet_ids
}
