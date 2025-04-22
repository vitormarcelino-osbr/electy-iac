output "instance_connection_name" {
  description = "The connection name of the Cloud SQL instance (used for private IP connection strings, etc.)"
  value       = google_sql_database_instance.postgres_instance.connection_name
}

output "instance_self_link" {
  description = "The self link of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres_instance.self_link
}

output "instance_private_ip" {
  description = "The private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres_instance.private_ip_address
}

output "instance_name" {
  description = "Name of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres_instance.name
}

output "database_names" {
  description = "List of database names created in the instance"
  value       = [for db in google_sql_database.database : db.name]
}

output "user_names" {
  description = "List of SQL user names created in the instance"
  value       = [for user in google_sql_user.users : user.name]
}
