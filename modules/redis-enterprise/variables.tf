variable "redis_subscription_name" {
  description = "The name of the Redis Enterprise Cloud Subscription"
  type        = string
}

variable "redis_subscription_cidr" {
  description = "The name of the Redis Enterprise Cloud Subscription deployment's CIDR"
  type        = string
}

variable "gcp_region" {
  description = "The region to deploy the cluster in"
  type        = string
}

variable "redis_secret_key" {
  description = "The type of Redis DB to be deployed Options are 'OSS' or 'Ent'"
  type        = string
}

variable "redis_access_key" {
  description = "The type of Redis DB to be deployed Options are 'OSS' or 'Ent'"
  type        = string
}
