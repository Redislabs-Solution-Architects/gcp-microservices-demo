variable "gcp_network_name" {
  description = "The name of the GCP Network"
  type        = string
}

variable "gcp_project_id" {
  description = "The project ID to deploy the cluter into"
  type        = string
}

variable "redis_subscription_name" {
  description = "The name of the Redis Enterprise Cloud Subscription"
  type        = string
}

variable "redis_subscription_id" {
  description = "The Subscription ID for the Redis Database"
  type        = string
}