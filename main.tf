module "gcp-networking" {
  source         	= "./modules/gcp-networking"
  cluster_name   	= var.cluster_name
  gcp_project_id 	= var.gcp_project_id
  gcp_region     	= var.gcp_region
}

module "gke-cluster" {
  depends_on = [
    module.gcp-networking
  ]
  source              = "./modules/gke-cluster"
  cluster_name        = format("gke-%s", var.cluster_name)
  gcp_project_id      = var.gcp_project_id
  gcp_region          = var.gcp_region
  gke_node_count      = var.gke_node_count
  gke_release_channel = var.gke_release_channel
  gke_machine_type    = var.gke_machine_type
  gcp_network_name    = module.gcp-networking.gcp_network_name
  gcp_subnet_name     = module.gcp-networking.gcp_subnet_name
}

module "redis-enterprise" {
  depends_on = [
    module.gcp-networking
  ]
  source             		 = "./modules/redis-enterprise"
  redis_subscription_name        = var.redis_subscription_name
  redis_subscription_cidr 	 = var.redis_subscription_cidr
  gcp_project_id       		 = var.gcp_project_id
  gcp_region	  		 = var.gcp_region
  gcp_network_name   		 = module.gcp-networking.gcp_network_name
}

