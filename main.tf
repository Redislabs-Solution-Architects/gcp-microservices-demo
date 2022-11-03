terraform {
  required_providers {
    rediscloud = {
      source = "RedisLabs/rediscloud"
    }
  }
}

provider "rediscloud" {
  api_key    = var.redis_access_key
  secret_key = var.redis_secret_key
}

module "gcp-networking" {
  source         = "./modules/gcp-networking"
  cluster_name   = var.cluster_name
  gcp_project_id = var.gcp_project_id
  gcp_region     = var.gcp_region
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
  source                  = "./modules/redis-enterprise"
  redis_subscription_name = format("gke-%s", var.cluster_name)
  redis_subscription_cidr = var.redis_subscription_cidr
  gcp_project_id          = var.gcp_project_id
  gcp_region              = var.gcp_region
  gcp_network_name        = module.gcp-networking.gcp_network_name
  redis_access_key        = var.redis_access_key
  redis_secret_key        = var.redis_secret_key
}

locals {
  redis_connection_string = lower(var.redis_db_type) == "ent" ? module.redis-enterprise.redis_connection_string : "redis-cart:6379"
}

module "cloud-services" {
  depends_on = [
    module.gke-cluster,
    module.redis-enterprise
  ]
  source                  = "./modules/cloud-services"
  cluster_name            = format("gke-%s", var.cluster_name)
  domain_name             = var.domain_name
  email_address           = var.email_address
  cert_manager_version    = var.cert_manager_version
  gcp_region              = var.gcp_region
  gcp_project_id          = var.gcp_project_id
  redis_connection_string = local.redis_connection_string
  redis_db_type           = lower(var.redis_db_type)
}
