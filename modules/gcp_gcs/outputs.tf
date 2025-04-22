output "bucket_name" {
  description = "Nome do bucket criado"
  value       = google_storage_bucket.bucket.name
}

output "bucket_self_link" {
  description = "Self-link do bucket"
  value       = google_storage_bucket.bucket.self_link
}

output "bucket_url" {
  description = "URL do bucket (gs://...)"
  value       = "gs://${google_storage_bucket.bucket.name}"
}