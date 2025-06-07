#
# RDS Postgress cluster
#
module "superset_db" {
  source = "github.com/cds-snc/terraform-modules//rds?ref=v10.4.7"
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

  # Enable audit logging to CloudWatch
  db_cluster_parameter_group_name          = aws_rds_cluster_parameter_group.superset_db.name
  enabled_cloudwatch_logs_exports          = ["postgresql"]
  cloudwatch_log_exports_retention_in_days = 30

  serverless_min_capacity = var.superset_database_min_capacity
  serverless_max_capacity = var.superset_database_max_capacity

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [aws_security_group.superset_db.id]

  billing_tag_value = var.billing_code
}

resource "aws_rds_cluster_parameter_group" "superset_db" {
  name        = "superset-db-pg-audit"
  family      = "aurora-postgresql15"
  description = "RDS parameter group that enables pgAudit"

  parameter {
    name         = "shared_preload_libraries"
    value        = "pgaudit,pg_stat_statements"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "pgaudit.log"
    value        = "role,write,ddl"
    apply_method = "pending-reboot"
  }

  tags = local.common_tags
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
