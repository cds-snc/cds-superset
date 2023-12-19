locals { 
  prefix = "cds"
  common_tags = {
    Terraform = "true",
    CostCentre = var.billing_code,
  }
}

module "vpc" {

  source = "github.com/cds-snc/terraform-modules//vpc?ref=v7.2.5"
  name   = "superspace-${var.env}"

  high_availability  = false
  enable_flow_log    = true 
  single_nat_gateway = true
  allow_https_request_out          = true
  allow_https_request_out_response = true
  allow_https_request_in           = true
  allow_https_request_in_response  = true

  billing_tag_value = var.billing_code
}

# module "superset-db" {
#   source            = "../../../stacks/aws/superset-db"
#   prefix            = local.prefix
#   vpc_id            = module.base.vpc_id
#   identifier        = var.db_identifier
#   allocated_storage = var.allocated_storage
#   cidr_block        = module.base.cidr_block
#   db_config         = var.superset_db_config
#   subnet_ids        = module.vpc.private_subnet_ids
#   kms               = module.base.kms_arn
#   instance_class    = var.instance_class
#   security_group = [
#     module.base.default_sg_id,
#     module.superset-core.ecs_service_security_group_id,
#     module.superset-core.app_service_security_group_id,
#     module.superset-core.worker_beat_service_security_group_id,
#     data.terraform_remote_state.east1_adm.outputs.argo_sg_id
#   ]
# }

module "superset-redis" {
  source               = "../modules/aws/redis"
  prefix               = local.prefix
  common_tags          = local.common_tags
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  node_type            = var.node_type 
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = 6379
  # allowed_security_groups = {
  #   "worker"      = module.superset-core.ecs_service_security_group_id
  #   "app"         = module.superset-core.app_service_security_group_id
  #   "worker_beat" = module.superset-core.worker_beat_service_security_group_id
  # }
}

# module "superset-core" {
#   source             = "../../../stacks/aws/superset-core-apps"
#   repository_name    = join("-", [local.prefix, "superset"])
#   prefix             = local.prefix
#   common_tags        = local.common_tags
#   kms_arn            = module.base.kms_arn
#   vpc_id             = module.base.vpc_id
#   private_subnet_ids = module.base.private_subnet_ids
#   service_discovery  = module.base.service_discovery
#   ecs_cluster        = module.base.ecs_cluster
#   env_vars           = var.env_vars
#   public_alb         = module.base.public_alb
#   worker_ecs_params = {
#     desired_count  = 1
#     cpu            = 512
#     memory         = 1024
#     port           = 8088
#     container_name = "superset-wrk"
#   }
#   worker_beat_ecs_params = {
#     desired_count  = 1
#     cpu            = 512
#     memory         = 1024
#     port           = 8088
#     container_name = "superset-beat"
#   }
#   app_ecs_params = {
#     desired_count  = 1
#     cpu            = 2048
#     memory         = 4096
#     port           = 8088
#     container_name = "superset-app"
#   }
#   alb_security_group = module.base.public_alb.sg_id
#   ssm_role_arn       = data.terraform_remote_state.east1_adm.outputs.ssm_role_arn
# }