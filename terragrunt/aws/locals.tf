locals {
  prefix = "cds"
  common_tags = {
    Terraform  = "true"
    CostCentre = var.billing_code
    ssc_cbrid  = "22DI"
  }

  core_tags = merge(local.common_tags, {
    ssc_cbrid = "22DH"
  })
}