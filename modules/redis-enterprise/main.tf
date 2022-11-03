#
# Provision for GCP MP subscription
#
# Set the following variables in your shell environment:
# export GOOGLE_APPLICATION_CREDENTIALS=<your Google APIs credentials>
# export REDISCLOUD_ACCESS_KEY=<your Redis Enterrpise Cloud api access key>
# export REDISCLOUD_SECRET_KEY=<your Redis Enterprise Cloud secret key>
#
# How to deploy:
# % terraform init
# % terraform plan
# % terraform apply
#
# How to tear down:
# % terraform destroy
# 

terraform {
  required_providers {
    rediscloud = {
      source = "RedisLabs/rediscloud"
    }
  }
}

resource "rediscloud_subscription" "mc-example" {
  name           = var.redis_subscription_name
  memory_storage = "ram"
  payment_method = "marketplace"

  cloud_provider {
    provider         = "GCP"
    cloud_account_id = 1

    region {
      region                       = var.gcp_region
      networking_deployment_cidr   = var.redis_subscription_cidr
      preferred_availability_zones = []
    }
  }

  creation_plan {
    average_item_size_in_bytes   = 1
    memory_limit_in_gb           = 1
    quantity                     = 1
    replication                  = false
    support_oss_cluster_api      = false
    throughput_measurement_by    = "operations-per-second"
    throughput_measurement_value = 25000
    modules                      = []
  }
}

resource "rediscloud_subscription_database" "mc-example" {
  subscription_id              = rediscloud_subscription.mc-example.id
  name                         = "online-boutique-cart"
  protocol                     = "redis"
  memory_limit_in_gb           = 1
  replication                  = true
  data_persistence             = "aof-every-1-second"
  throughput_measurement_by    = "operations-per-second"
  throughput_measurement_value = 25000
  average_item_size_in_bytes   = 0
  depends_on                   = [rediscloud_subscription.mc-example]
}

data "google_compute_network" "network" {
  project = var.gcp_project_id
  name    = var.gcp_network_name
}

resource "rediscloud_subscription_peering" "mc-example-peering" {
  subscription_id  = rediscloud_subscription.mc-example.id
  provider_name    = "GCP"
  gcp_project_id   = data.google_compute_network.network.project
  gcp_network_name = data.google_compute_network.network.name
}

resource "google_compute_network_peering" "mc-example-peering" {
  name         = format("online-boutique-%s", var.redis_subscription_name)
  network      = data.google_compute_network.network.self_link
  peer_network = "https://www.googleapis.com/compute/v1/projects/${rediscloud_subscription_peering.mc-example-peering.gcp_redis_project_id}/global/networks/${rediscloud_subscription_peering.mc-example-peering.gcp_redis_network_name}"
}
