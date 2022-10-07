variable "redis_subscription_name" {
  description = "The name of the Redis Enterprise Cloud Subscription"
  type        = string
}

variable "redis_subscription_cidr" {
  description = "The name of the Redis Enterprise Cloud Subscription deployment's CIDR"
  type        = string
}

variable "gcp_project_id" {
  description = "The project ID to deploy the cluter into"
  type        = string
}

variable "gcp_region" {
  description = "The region to deploy the cluster in"
  type        = string
}

variable "gcp_network_name" {
  description = "The name of the GCP Network"
  type        = string
}

