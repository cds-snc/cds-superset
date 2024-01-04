variable "node_type" {
  type        = string
  default     = "cache.t2.micro"
  description = "The compute and memory capacity of the nodes in the node group (shard)."
}

variable "parameter_group_name" {
  type        = string
  default     = "default.redis7"
  description = "The name of the parameter group to associate with this cluster."
}

variable "engine_version" {
  type        = string
  default     = "7.1"
  description = "The version number of the cache engine to be used for the cache cluster."
}