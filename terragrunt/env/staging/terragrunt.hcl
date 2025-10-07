terraform {
  source = "../..//aws"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  data_lake_account_access = [
    {
      env_name   = "production"
      account_id = "739275439843"
    },
    {
      env_name   = "staging"
      account_id = "454671348950"
    }
  ]

  glue_databases = [
    "platform_gc_forms_production",
    "platform_gc_forms_staging",
    "platform_gc_notify_production",
    "platform_gc_notify_staging",
    "platform_gc_design_system_production",
    "platform_gc_design_system_staging",
    "platform_support_production",
    "platform_support_staging",
    "operations_aws_production",
    "operations_github_production",
    "bes_crm_salesforce_production",
  ]

  superset_database_instance_class  = "db.serverless"
  superset_database_instances_count = 1
  superset_database_min_capacity    = 0
  superset_database_max_capacity    = 4
}
