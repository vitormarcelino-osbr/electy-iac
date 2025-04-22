variable "env" {
  description = "Ambiente de execução"
  type        = string
}

variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região padrão para recursos GCP"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Nome do bucket GCS (deve ser único globalmente)"
  type        = string
}

variable "uniform_bucket_level_access" {
  description = "Força UBLA em todos os buckets"
  type        = bool
  default     = true
}