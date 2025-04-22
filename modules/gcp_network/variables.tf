variable "project_id" {
  type        = string
  description = "ID do projeto GCP"
}

variable "region" {
  type        = string
  description = "Região GCP para a sub-rede"
}

variable "network_name" {
  type        = string
  description = "Nome da rede VPC"
}
