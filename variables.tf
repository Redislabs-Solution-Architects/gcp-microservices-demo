variable "cluster_name" {
  description = "The name of the GKE cluster"
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

variable "gke_node_count" {
  description = "The number of nodes to deploy in the cluster"
  type        = number
}

variable "gke_release_channel" {
  description = "The gke release channel to deploy"
  type        = string
}

variable "gke_machine_type" {
  description = "The type of machine to deploy"
  type        = string
}

variable "redis_subscription_name" {
  description = "The name of the Redis Enterprise Cloud Subscription"
  type        = string
}

variable "redis_subscription_cidr" {
  description = "The name of the Redis Enterprise Cloud Subscription deployment's CIDR"
  type        = string
}

