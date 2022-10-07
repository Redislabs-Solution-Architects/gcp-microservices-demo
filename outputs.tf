output "gke_cluster_name" {
  value = module.gke-cluster.gke_cluster_name
}

output "region" {
  value = module.gke-cluster.region
}

output "db_private_endpoint" {
  value = module.redis-enterprise.db_private_endpoint
}

output "db_password" {
  value = module.redis-enterprise.db_password
  sensitive = true
}

