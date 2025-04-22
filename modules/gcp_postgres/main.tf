terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  project          = var.project_id

  depends_on = [var.vpc_peering_dependency]

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = "PD_SSD"
    disk_size         = var.disk_size
    disk_autoresize   = true

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network
      ssl_mode        = var.ssl_mode
    }

    backup_configuration {
      enabled                        = true
      location                       = var.region
      start_time                     = "02:00"
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 7

      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }

    maintenance_window {
      day          = 7
      hour         = 2
      update_track = "stable"
    }

    database_flags {
      name  = "max_connections"
      value = var.max_connections
    }

    user_labels = var.labels
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "database" {
  count     = length(var.databases)
  name      = var.databases[count.index].name
  instance  = google_sql_database_instance.postgres_instance.name
  project   = var.project_id
  charset   = lookup(var.databases[count.index], "charset", "UTF8")
  collation = lookup(var.databases[count.index], "collation", "en_US.UTF8")
}

resource "google_sql_user" "users" {
  count    = length(var.users)
  name     = var.users[count.index].name
  password = var.users[count.index].password
  instance = google_sql_database_instance.postgres_instance.name
  project  = var.project_id
}