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
    }
  ]

  glue_databases = [
    "operations_aws_production",
    "platform_gc_forms_production",
    "platform_gc_notify_production",
    "platform_support_production",
  ]

  superset_database_instance_class  = "db.serverless"
  superset_database_instances_count = 1
  superset_database_min_capacity    = 0.5
  superset_database_max_capacity    = 4
}
