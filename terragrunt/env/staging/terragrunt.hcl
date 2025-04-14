terraform {
  source = "../..//aws"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  glue_databases = [
    "platform_gc_forms_production",
    "platform_gc_notify_production",
    "platform_support_production",
    "operations_aws_production",
    "bes_crm_salesforce_production",
  ]
  superset_database_instance_class  = "db.serverless"
  superset_database_instances_count = 1
  superset_database_min_capacity    = 1
  superset_database_max_capacity    = 4
}
