variable "env" {
  description = "Ambiente de execução"
  type        = string
}

variable "worker" {
  description = "Worker"
  type        = string
}

variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "network_name" {
  description = "Nome da VPC"
  type        = string
}

variable "region" {
  description = "Região padrão para recursos GCP"
  type        = string
  default     = "us-central1"
}

variable "uniform_bucket_level_access" {
  description = "Força UBLA em todos os buckets"
  type        = bool
  default     = true
}