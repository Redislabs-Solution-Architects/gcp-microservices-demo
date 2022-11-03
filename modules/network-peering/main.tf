terraform {
  required_providers {
    rediscloud = {
      source = "RedisLabs/rediscloud"
    }
  }
}

data "google_compute_network" "network" {
  project = var.gcp_project_id
  name    = var.gcp_network_name
}

resource "rediscloud_subscription_peering" "mc-example-peering" {
  subscription_id  = var.redis_subscription_id
  provider_name    = "GCP"
  gcp_project_id   = data.google_compute_network.network.project
  gcp_network_name = data.google_compute_network.network.name
}

resource "google_compute_network_peering" "mc-example-peering" {
  name         = format("online-boutique-%s", var.redis_subscription_name)
  network      = data.google_compute_network.network.self_link
  peer_network = "https://www.googleapis.com/compute/v1/projects/${rediscloud_subscription_peering.mc-example-peering.gcp_redis_project_id}/global/networks/${rediscloud_subscription_peering.mc-example-peering.gcp_redis_network_name}"
}
