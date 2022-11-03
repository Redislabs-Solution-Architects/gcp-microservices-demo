variable "cluster_name" {
  description = "The GKE Cluster Name"
  type        = string
}

variable "gcp_project_id" {
  description = "The project ID to deploy the cluster into"
  type        = string
}

variable "gcp_region" {
  description = "The GCP Region"
  type        = string
  default     = "us-central1"
}
