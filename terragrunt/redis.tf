module "superset-redis" {
  source               = "../modules/aws/redis"
  prefix               = local.prefix
  common_tags          = local.common_tags
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  node_type            = "cache.t2.micro"
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  allowed_security_groups = {
  #   "worker"      = module.superset-core.ecs_service_security_group_id
  #   "app"         = module.superset-core.app_service_security_group_id
  #   "worker_beat" = module.superset-core.worker_beat_service_security_group_id
  "app" = aws_security_group.superset_ecs
  }
}