variable "project_id" {
  type        = string
  description = "ID do projeto GCP"
}

variable "region" {
  type        = string
  description = "Região do repositório"
}

variable "repository_id" {
  type        = string
  description = "ID do repositório (nome único)"
}

variable "description" {
  type        = string
  description = "Descrição do repositório"
  default     = "Repositório Artifact Registry"
}

variable "format" {
  type        = string
  description = "Formato do repositório (ex: DOCKER, NPM, MAVEN...)"
}
