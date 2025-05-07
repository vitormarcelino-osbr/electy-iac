locals {
  bucket_name = "stoworker${var.worker}${var.env}"
  db_instance_name = "dbworker${var.worker}${var.env}"
  network_name  = "vpc-${var.worker}-${var.env}"
  repository_id = "registry${var.worker}${var.env}"
  cluster_name = "gke${var.worker}${var.env}"
}
module "gcp_network" {
  source        = "../../modules/gcp_network"
  region        = var.region
  network_name  = local.network_name
  project_id    = var.project_id
}

module "gcp_gcs" {
  source = "../../modules/gcp_gcs"

  bucket_name   = local.bucket_name
  project_id    = var.project_id
  region        = var.region
  storage_class = "standard"
}

module "gcp_postgres" {
  source = "../../modules/gcp_postgres"

  project_id           = "gifted-pattern-455417-c4"
  region               = "us-central1"
  instance_name        = "postgres-${var.env}"
  database_version     = "POSTGRES_15"
  tier                 = "db-custom-1-3840"
  availability_type    = "ZONAL"
  disk_size            = 100
  ssl_mode             = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"

  max_connections      = "100"
  deletion_protection  = false

  private_network       = "projects/${var.project_id}/global/networks/${module.gcp_network.network_name}"
  vpc_peering_dependency = module.gcp_network.vpc_peering

  labels = {
    env = var.env
  }
  
  databases = [
    {
      name     = "defaultdb"
      charset  = "UTF8"
      collation = "en_US.UTF8"
    }
  ]
  users = [
    {
      name     = "adminuser"
      password = "_ElectyBD@30092022_"
    }
  ]
}

module "gcp_artifact_registry" {
  source = "../../modules/gcp_artifact_registry"

  project_id     = var.project_id
  region         = var.region
  repository_id  = local.repository_id
  description    = "Repositório Docker para o ambiente ${var.env}"
  format         = "DOCKER"
}

module "gcp_gke" {
source                      = "../../modules/gcp_gke"
  cluster_name                = local.cluster_name
  project_id                  = var.project_id
  region                      = var.region
  network_name                = module.gcp_network.network_name
  subnetwork_name             = module.gcp_network.subnet_name
  initial_node_count          = 1
  machine_type                = "e2-standard-2"
  enable_private_nodes        = false
  enable_private_endpoint     = false
  min_node_count              = 1
  max_node_count              = 5
  env                         = var.env
  # cluster_ipv4_cidr_block     = "10.0.0.0/16"  # Opcional - pode ser omitido
  # services_ipv4_cidr_block    = "10.1.0.0/16"  # Opcional - pode ser omitido
}


# module "gke_cluster" {
#   source = "../../modules/gcp_gke"

#   cluster_name               = "gke-worker"
#   region                     = var.region
#   project_id                 = var.project_id
#   network                    = module.gcp_network.network_name
#   subnetwork                 = module.gcp_network.subnetwork_name
#   pods_secondary_range_name  = "pods-range"
#   services_secondary_range_name = "services-range"
#   machine_type               = "e2-standard-2"
#   node_count                 = 1
#   env                        = var.env
#   master_password            = "supersecure"
# }
