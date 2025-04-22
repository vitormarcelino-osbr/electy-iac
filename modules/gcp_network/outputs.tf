output "network_name" {
  value       = google_compute_network.vpc.name
  description = "Nome da VPC criada"
}

output "network_self_link" {
  value       = google_compute_network.vpc.self_link
  description = "Self link da VPC (para uso em Cloud SQL, etc.)"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Nome da sub-rede"
}

output "vpc_peering" {
  description = "The VPC Peering connection resource"
  value       = google_service_networking_connection.vpc_peering
}