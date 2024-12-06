terraform {
  source = "../..//aws"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  superset_database_instance_class  = "db.t3.medium"
  superset_database_instances_count = 2
}
