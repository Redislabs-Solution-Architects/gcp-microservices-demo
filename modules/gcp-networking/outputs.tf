output "gcp_network_name" {
  value       = google_compute_network.gcp_network.name
  description = "The name of the GCP Network"
}

output "gcp_subnet_name" {
  value       = google_compute_subnetwork.k8s.self_link
  description = "The name of the GCP Subnet"
}
