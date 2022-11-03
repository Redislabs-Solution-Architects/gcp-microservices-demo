variable "gcp_project_id" {
  description = "The project ID to deploy the cluter into"
  type        = string
}

variable "domain_name" {
  description = "The domain name to use for DNS records"
  type        = string
}

variable "email_address" {
  description = "The email address to use with Cert Manager"
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

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "boutique"
}

variable "gcp_region" {
  description = "The region to deploy the cluster in"
  type        = string
  default     = "us-central1"
}

variable "gke_node_count" {
  description = "The number of nodes to deploy in the cluster"
  type        = number
  default     = 1
}

variable "gke_release_channel" {
  description = "The gke release channel to deploy"
  type        = string
  default     = "RAPID"
}

variable "gke_machine_type" {
  description = "The type of machine to deploy"
  type        = string
  default     = "c2-standard-4"
}

variable "redis_subscription_cidr" {
  description = "The name of the Redis Enterprise Cloud Subscription deployment's CIDR"
  type        = string
  default     = "192.168.0.0/24"
}

variable "cert_manager_version" {
  description = "The version of cert manager to install"
  type        = string
  default     = "v1.10.0"
}

variable "redis_db_type" {
  description = "The type of Redis DB to be setup by default. Valid options are 'OSS' or 'Ent'"
  default     = "OSS"
  type        = string
}
