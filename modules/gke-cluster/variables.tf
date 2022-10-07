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

variable "gcp_network_name" {
  description = "The name of the GCP Network"
  type        = string
}

variable "gcp_subnet_name" {
  description = "The name of the GCP Network"
  type        = string
}
