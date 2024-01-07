variable "project_id" {
  type        = string
  description = "ID of the Google Project"
}

variable "region" {
  type        = string
  description = "Default Region"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "Default Zone"
  default     = "us-central1-a"
}

variable "network" {
  type = object({
    name                = string
    subnetwork_name     = string
    nodes_cidr_range    = optional(string, "10.128.0.0/20")
    pods_cidr_range     = optional(string, "10.4.0.0/14")
    services_cidr_range = optional(string, "10.8.0.0/20")
  })
  description = "value for VPC Network"
}

variable "gke" {
  type = object({
    name     = string
    regional = optional(bool, false)
    zones    = list(string)
  })

  default = {
    name     = "gke-cluster"
    regional = true
    zones    = ["us-central1-b", "us-central1-c", "us-central1-f"]
}
  description = "value for GKE Cluster"
}

variable "node_pool" {
  type = object({
    name               = string
    machine_type       = optional(string, "e2-small")
    spot               = optional(bool, true)
    initial_node_count = optional(number, 2)
    max_count          = optional(number, 4)
    disk_size_gb       = optional(number, 10)
  })
  description = "value for GKE Node Pool"
}

variable "service_account" {
  type = object({
    name  = string
    roles = list(string)
  })
  default = {
  name  = "registry-sa"
  roles = [
    "artifactregistry.reader"
  ]
}
  description = "Service Account for GKE"
}

variable "services" {
  type = list(string)
  description = "List of services to enable"
  default = [
    "cloudresourcemanager",
    "compute",
    "container",
    "iam",
    "servicenetworking",
    "artifactregistry",
    "cloudbuild",
  ]
}

variable "repository_id" {
  type = string
  description = "ID of the Artifact Registry repository"
  default = "docker-repo"
}