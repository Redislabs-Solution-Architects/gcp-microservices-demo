variable "cluster_name" {
  description = "The name(s) of the clusters to be deployed"
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

variable "cert_manager_version" {
  description = "The version of cert manager to install"
  type        = string
}

variable "gcp_region" {
  description = "The GCP Region"
  type        = string
}

variable "gcp_project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "redis_connection_string" {
  description = "The connection string of the Redis DB"
  type        = string
}

variable "redis_db_type" {
  description = "The type of Redis DB to be deployed Options are 'OSS' or 'Ent'"
  type        = string
}
