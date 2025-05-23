#
# RDS Postgress cluster
#
module "superset_db" {
  source = "github.com/cds-snc/terraform-modules//rds?ref=v10.4.5"
  name   = "superset-${var.env}"

  database_name  = "superset"
  engine         = "aurora-postgresql"
  engine_version = "15.10"
  instances      = var.superset_database_instances_count
  instance_class = var.superset_database_instance_class
  username       = var.superset_database_username
  password       = var.superset_database_password

  backup_retention_period      = 14
  preferred_backup_window      = "02:00-04:00"
  performance_insights_enabled = true

  serverless_min_capacity = var.superset_database_min_capacity
  serverless_max_capacity = var.superset_database_max_capacity

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [aws_security_group.superset_db.id]

  billing_tag_value = var.billing_code
}

resource "aws_ssm_parameter" "superset_database_host" {
  name  = "superset_database_host"
  type  = "SecureString"
  value = module.superset_db.proxy_endpoint
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "superset_database_username" {
  name  = "superset_database_username"
  type  = "SecureString"
  value = var.superset_database_username
  tags  = local.common_tags
}

resource "aws_ssm_parameter" "superset_database_password" {
  name  = "superset_database_password"
  type  = "SecureString"
  value = var.superset_database_password
  tags  = local.common_tags
}
