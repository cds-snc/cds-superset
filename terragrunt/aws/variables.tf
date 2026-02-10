variable "account_id" {
  description = "(Required) The account ID to perform actions on."
  type        = string
}

variable "billing_code" {
  description = "The billing code to tag our resources with"
  type        = string
}

variable "cbs_satellite_bucket_name" {
  description = "The name of the Cloud Based Sensor satellite bucket"
  type        = string
}

variable "cloudwatch_alert_slack_webhook" {
  description = "Slack webhook URL used by the CloudWatch alarm SNS topics."
  type        = string
  sensitive   = true
}

variable "data_lake_account_access" {
  description = "List of data lake accounts that Superset has access to."
  type = list(object({
    env_name   = string
    account_id = string
  }))
}

variable "domain" {
  description = "The domain to use for the service."
  type        = string
}

variable "env" {
  description = "The current running environment"
  type        = string
}

variable "glue_databases" {
  description = "List of Glue databases to grant access to."
  type        = list(string)
}

variable "google_oauth_client_id" {
  description = "Google OAuth client ID to enable logging in with Google."
  type        = string
  sensitive   = true
}

variable "google_oauth_client_secret" {
  description = "Google OAuth client secret to enable logging in with Google."
  type        = string
  sensitive   = true
}

variable "zitadel_domain" {
  description = "The domain of the Zitadel instance to use for authentication."
  type        = string
}

variable "zitadel_oauth_client_id" {
  description = "Zitadel OAuth client ID to enable logging in with Zitadel."
  type        = string
  sensitive   = true
}

variable "zitadel_oauth_client_secret" {
  description = "Zitadel OAuth client secret to enable logging in with Zitadel."
  type        = string
  sensitive   = true
}

variable "guest_token_jwt_secret" {
  description = "The secret for guest embedded dashboard JWT tokens."
  type        = string
  sensitive   = true
}

variable "ecs_task_superset_cpu" {
  description = "The amount of CPU units to allocate to the Superset ECS task."
  type        = number
}

variable "ecs_task_superset_memory" {
  description = "The amount of memory (in MiB) to allocate to the Superset ECS task."
  type        = number
}

variable "ecs_task_celery_worker_cpu" {
  description = "The amount of CPU units to allocate to the Celery Worker ECS task."
  type        = number
}

variable "ecs_task_celery_worker_memory" {
  description = "The amount of memory (in MiB) to allocate to the Celery Worker ECS task."
  type        = number
}

variable "ecs_task_celery_beat_cpu" {
  description = "The amount of CPU units to allocate to the Celery Beat ECS task."
  type        = number
}

variable "ecs_task_celery_beat_memory" {
  description = "The amount of memory (in MiB) to allocate to the Celery Beat ECS task."
  type        = number
}

variable "product_name" {
  description = "(Required) The name of the product you are deploying."
  type        = string
}

variable "region" {
  description = "The current AWS region"
  type        = string
}

variable "slack_api_token" {
  description = "Slack API token for sending alerts and reports."
  type        = string
  sensitive   = true
}

variable "sentinel_workspace_id" {
  description = "Workspace ID for Sentinel Forwarder."
  type        = string
  sensitive   = true
}

variable "sentinel_workspace_key" {
  description = "Workspace key for Sentinel Forwarder."
  type        = string
  sensitive   = true
}

variable "smtp_password" {
  description = "The SMTP password for sending emails."
  type        = string
  sensitive   = true
}

variable "smtp_user" {
  description = "The SMTP user for sending emails."
  type        = string
  sensitive   = true
}

variable "superset_cluster_capacity_provider" {
  description = "The capacity provider to use for the ECS cluster."
  type        = string
}

variable "superset_database_instances_count" {
  description = "The number of instances in the database cluster."
  type        = number
}

variable "superset_database_instance_class" {
  description = "The instance class to use for the database."
  type        = string
}

variable "superset_database_max_capacity" {
  description = "The maximum capacity for the serverless database."
  type        = number
}

variable "superset_database_min_capacity" {
  description = "The minimum capacity for the serverless database."
  type        = number
}

variable "superset_database_username" {
  description = "The username to use for the database."
  type        = string
  sensitive   = true
}

variable "superset_database_password" {
  description = "The password to use for the database."
  type        = string
  sensitive   = true
}

variable "superset_secret_key" {
  description = "Superset's secret key"
  type        = string
  sensitive   = true
}

variable "upptime_status_header" {
  description = "The header to check for Upptime status check requests."
  type        = string
  sensitive   = true
}