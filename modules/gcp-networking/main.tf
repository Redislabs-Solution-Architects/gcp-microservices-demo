resource "google_compute_network" "gcp_network" {
  name                    = format("%s-network", var.cluster_name)
  project                 = var.gcp_project_id
  auto_create_subnetworks = false
  mtu                     = 1500
}

resource "google_compute_subnetwork" "k8s" {
  name          = "k8s"
  project       = var.gcp_project_id
  region        = var.gcp_region
  network       = google_compute_network.gcp_network.id
  ip_cidr_range = "10.123.128.0/18"
  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.124.0.0/14"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.123.240.0/20"
  }
}
