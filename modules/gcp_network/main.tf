resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.network_name}-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  project       = var.project_id
  network       = google_compute_network.vpc.id
}

resource "google_compute_global_address" "private_ip_block" {
  name          = "${var.network_name}-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

resource "google_service_networking_connection" "vpc_peering" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]

  depends_on = [
    google_compute_global_address.private_ip_block
  ]
}
