resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.region
  project                  = var.project_id
  remove_default_node_pool = true
  initial_node_count       = var.initial_node_count
  network                  = var.network_name
  subnetwork               = var.subnetwork_name
  deletion_protection      = false

  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "acesso-temporario"
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = var.cluster_ipv4_cidr_block
    services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }

  depends_on = [
    google_project_service.container_api
  ]
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  project    = var.project_id
  cluster    = google_container_cluster.primary.name
  node_count = var.initial_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      env = var.env
    }

    tags = ["gke-node", var.env]
  }
}

resource "google_project_service" "container_api" {
  project = var.project_id
  service = "container.googleapis.com"

  disable_on_destroy = false
}
