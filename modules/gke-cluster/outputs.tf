output "gke_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster"
}

output "region" {
  value       = google_container_cluster.primary.location
  description = "The Region the GKE cluster is deployed"
}
