######################
#     VARIABLES      |
######################
# General
# -------
variable "prefix" {}

variable "common_tags" {
  type = map(string)
}

# Network
# -------
variable "vpc_id" {}

variable "allowed_security_groups" {
  default = {}
  type    = map(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

# Engine
# -------
variable "node_type" {
  type = string
}

variable "engine" {
  type        = string
  description = "this is defaulted to redis to create elasticache redis resource"
  default     = "redis"
}

variable "engine_version" {
  type = string
}

variable "port" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

variable "allowed_cidr_blocks" {
  default = {}
  type    = map(string)
}
