#
# Create Athena queries to view the WAF and load balancer access logs
#
module "athena_access_logs" {
  source = "github.com/cds-snc/terraform-modules//athena_access_logs?ref=v10.6.2"

  athena_bucket_name = module.athena_bucket.s3_bucket_id

  lb_access_queries_create   = true
  lb_access_log_bucket_name  = var.cbs_satellite_bucket_name
  waf_access_queries_create  = true
  waf_access_log_bucket_name = var.cbs_satellite_bucket_name

  billing_tag_value = var.billing_code
}

#
# Hold the Athena data
#
module "athena_bucket" {
  source            = "github.com/cds-snc/terraform-modules//S3?ref=v10.6.2"
  bucket_name       = "${var.product_name}-${var.env}-athena"
  billing_tag_value = var.billing_code

  versioning = {
    enabled = true
  }

  lifecycle_rule = [
    {
      id      = "expire-objects"
      enabled = true
      expiration = {
        days = 30
      }
    },
  ]
}

resource "aws_athena_data_catalog" "data_lake" {
  for_each = {
    for account in var.data_lake_account_access :
    account.env_name => account.account_id
  }

  name        = "data-lake-${each.key}"
  description = "Data catalog for access to the CDS data lake"
  type        = "GLUE"

  parameters = {
    "catalog-id" = each.value
  }
}
