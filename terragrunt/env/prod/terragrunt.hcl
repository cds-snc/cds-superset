terraform {
  source = "../..//aws"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  superset_database_instance_class  = "db.serverless"
  superset_database_instances_count = 1
  superset_database_min_capacity    = 1
  superset_database_max_capacity    = 4
}
