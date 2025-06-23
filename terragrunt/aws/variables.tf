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

variable "superset_privileged_role_ids" {
  description = "List of role IDs that have privileged access to data."
  type        = list(number)
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