resource "google_storage_bucket" "default_bucket" {
  name                        = var.bucket_name
  location                    = var.region
  uniform_bucket_level_access = var.uniform_bucket_level_access
}