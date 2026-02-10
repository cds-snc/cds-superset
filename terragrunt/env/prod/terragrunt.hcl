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
    "operations_github_production",
    "operations_google_analytics_production",
    "operations_qualtrics_production",
    "platform_gc_forms_production",
    "platform_gc_notify_production",
    "platform_gc_design_system_production",
    "platform_support_production",
  ]

  ecs_task_superset_cpu         = 2048
  ecs_task_superset_memory      = 6144
  ecs_task_celery_worker_cpu    = 2048
  ecs_task_celery_worker_memory = 6144
  ecs_task_celery_beat_cpu      = 512
  ecs_task_celery_beat_memory   = 1024

  superset_cluster_capacity_provider = "FARGATE"
  superset_database_instance_class   = "db.serverless"
  superset_database_instances_count  = 1
  superset_database_min_capacity     = 0.5
  superset_database_max_capacity     = 4

  zitadel_domain = "idp.cdssandbox.xyz"
}
