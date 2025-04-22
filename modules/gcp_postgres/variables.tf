variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "instance_name" {
  type        = string
  description = "Cloud SQL instance name"
}

variable "database_version" {
  type        = string
  description = "Database version (e.g. POSTGRES_15)"
}

variable "tier" {
  type        = string
  description = "Machine type tier (e.g. db-custom-1-3840)"
}

variable "availability_type" {
  type        = string
  description = "Availability type (ZONAL or REGIONAL)"
}

variable "disk_size" {
  type        = number
  description = "Disk size in GB"
}

variable "ssl_mode" {
  type        = string
  default     = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
  description = "SSL mode for connections"
}

variable "max_connections" {
  type        = string
  default     = "100"
  description = "Maximum number of connections"
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "Whether to enable deletion protection"
}

variable "private_network" {
  type        = string
  description = "Full resource path to VPC network (e.g. projects/<project>/global/networks/<network>)"
}

variable "vpc_peering_dependency" {
  description = "Fake dependency to ensure VPC peering is created before SQL"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels to apply to resources"
}

variable "databases" {
  type = list(object({
    name      = string
    charset   = optional(string)
    collation = optional(string)
  }))
  description = "List of databases to create"
}

variable "users" {
  type = list(object({
    name     = string
    password = string
  }))
  description = "List of SQL users"
}
