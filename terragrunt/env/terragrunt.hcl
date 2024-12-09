locals {
  vars         = read_terragrunt_config("./env_vars.hcl")
  billing_code = "${local.vars.inputs.product_name}-${local.vars.inputs.env}"
}

inputs = {
  account_id                = local.vars.inputs.account_id
  domain                    = local.vars.inputs.domain
  domain_prod               = local.vars.inputs.domain_prod
  env                       = local.vars.inputs.env
  product_name              = local.vars.inputs.product_name
  region                    = local.vars.inputs.region
  billing_code              = local.billing_code
  cbs_satellite_bucket_name = "cbs-satellite-${local.vars.inputs.account_id}"
  superset_iam_role_arn     = "arn:aws:iam::${local.vars.inputs.account_id}:role/SupersetAthenaRead"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    encrypt             = true
    bucket              = "${local.billing_code}-tf"
    dynamodb_table      = "terraform-state-lock-dynamo"
    region              = "ca-central-1"
    key                 = "./terraform.tfstate"
    s3_bucket_tags      = { CostCenter : local.billing_code }
    dynamodb_table_tags = { CostCenter : local.billing_code }
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = file("./common/provider.tf")
}

generate "common_variables" {
  path      = "common_variables.tf"
  if_exists = "overwrite"
  contents  = file("./common/common_variables.tf")
}
