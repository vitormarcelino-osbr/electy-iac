resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.region
  project                     = var.project_id
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  force_destroy               = var.force_destroy

  # Configurações de versionamento (opcional)
  versioning {
    enabled = var.versioning_enabled
  }

  # Lifecycle Rules (opcional)
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action_type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                        = lookup(lifecycle_rule.value.condition, "age", null)
        created_before             = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state                 = lookup(lifecycle_rule.value.condition, "with_state", null)
        matches_storage_class      = lookup(lifecycle_rule.value.condition, "matches_storage_class", null)
        num_newer_versions         = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }

  # CORS (opcional)
  dynamic "cors" {
    for_each = var.cors_rules
    content {
      origin          = cors.value.origin
      method          = cors.value.method
      response_header = cors.value.response_header
      max_age_seconds = cors.value.max_age_seconds
    }
  }
}

# IAM para o bucket (opcional)
resource "google_storage_bucket_iam_member" "members" {
  for_each = { for role, members in var.iam_members : role => members }
  bucket   = google_storage_bucket.bucket.name
  role     = each.key
  member   = each.value
}