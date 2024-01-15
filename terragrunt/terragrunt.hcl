locals {
  account_id       = "066023111852"
  domain           = "superset.cdssandbox.xyz"
  env              = "prod"
  product_name     = "cds-superset"
  cost_center_code = "${local.product_name}-${local.env}"
}

# DO NOT CHANGE ANYTHING BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING

inputs = {
  account_id   = local.account_id
  domain       = local.domain
  env          = local.env
  product_name = local.product_name
  region       = "ca-central-1"
  billing_code = local.cost_center_code

  superset_database_instance_class  = "db.t3.medium"
  superset_database_instances_count = 2
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = file("../common/provider.tf")
}

generate "common_variables" {
  path      = "common_variables.tf"
  if_exists = "overwrite"
  contents  = file("../common/common_variables.tf")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    encrypt             = true
    bucket              = "${local.cost_center_code}-tf"
    dynamodb_table      = "terraform-state-lock-dynamo"
    region              = "ca-central-1"
    key                 = "${path_relative_to_include()}/terraform.tfstate"
    s3_bucket_tags      = { CostCenter : local.cost_center_code }
    dynamodb_table_tags = { CostCenter : local.cost_center_code }
  }
}