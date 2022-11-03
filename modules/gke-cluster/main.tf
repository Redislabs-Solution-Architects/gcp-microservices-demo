resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  project            = var.gcp_project_id
  location           = var.gcp_region
  network            = var.gcp_network_name
  subnetwork         = var.gcp_subnet_name
  networking_mode    = "VPC_NATIVE"
  initial_node_count = var.gke_node_count
  release_channel {
    channel = var.gke_release_channel
  }
  node_config {
    machine_type = var.gke_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite"
    ]
  }
  ip_allocation_policy {
    cluster_secondary_range_name  = format("%s-pod-range", var.cluster_name)
    services_secondary_range_name = format("%s-service-range", var.cluster_name)
  }
  lifecycle {
    ignore_changes = all
  }
}
