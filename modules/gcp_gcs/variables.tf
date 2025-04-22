variable "bucket_name" {
  description = "Nome globalmente único do bucket"
  type        = string
}

variable "project_id" {
  description = "ID do projeto GCP"
  type        = string
}

variable "region" {
  description = "Região do bucket (ex.: 'US', 'EUROPE-WEST1')"
  type        = string
  default     = "us-central1"
}

variable "storage_class" {
  description = "Classe de armazenamento (ex.: 'STANDARD', 'NEARLINE')"
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "Força UBLA (recomendado para segurança)"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Permite deletar bucket não vazio (cuidado!)"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Habilita versionamento de objetos"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "Regras de lifecycle para objetos"
  type = list(object({
    action_type = string
    action = map(any)
    condition = map(any)
  }))
  default = []
}

variable "cors_rules" {
  description = "Regras CORS para o bucket"
  type = list(object({
    origin          = list(string)
    method          = list(string)
    response_header = list(string)
    max_age_seconds = number
  }))
  default = []
}

variable "iam_members" {
  description = "Mapeamento de roles para membros IAM (ex.: { 'roles/storage.admin' = ['user:foo@bar.com'] })"
  type        = map(list(string))
  default     = {}
}