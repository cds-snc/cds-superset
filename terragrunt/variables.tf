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