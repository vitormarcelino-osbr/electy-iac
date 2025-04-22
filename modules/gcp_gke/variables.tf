# modules/gcp_gke/variables.tf
variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "project_id" {
  description = "The project ID to host the cluster in"
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network to which the cluster is connected"
  type        = string
}

variable "subnetwork_name" {
  description = "The name of the subnetwork to which the cluster is connected"
  type        = string
}

variable "initial_node_count" {
  description = "The number of nodes to create in this cluster's default node pool"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "The machine type for the nodes"
  type        = string
  default     = "e2-standard-2"
}

variable "enable_private_nodes" {
  description = "Whether nodes have internal IP addresses only"
  type        = bool
  default     = true
}

variable "enable_private_endpoint" {
  description = "Whether the master's internal IP address is used as the cluster endpoint"
  type        = bool
  default     = true
}

variable "min_node_count" {
  description = "Minimum number of nodes in the NodePool"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes in the NodePool"
  type        = number
  default     = 5
}

variable "master_authorized_networks" {
  description = "CIDR block to allow access to the master endpoint (set to null to disable)"
  type        = string
  default     = null
}

variable "env" {
  description = "Environment label for resources"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for the master's internal IP address"
  type        = string
  default     = "172.16.0.0/28"
}

variable "cluster_ipv4_cidr_block" {
  description = "CIDR block for pods in the cluster"
  type        = string
  default     = null
}

variable "services_ipv4_cidr_block" {
  description = "CIDR block for services in the cluster"
  type        = string
  default     = null
}

variable "disk_size_gb" {
  description = "Size of the disk attached to each node"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "Type of the disk attached to each node"
  type        = string
  default     = "pd-standard"
}