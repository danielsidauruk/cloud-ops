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
    nodes_cidr_range    = string
    pods_cidr_range     = string
    services_cidr_range = string
  })
  description = "value for VPC Network"

  default = {
    name                = "gke-network"
    subnetwork_name     = "private"
    nodes_cidr_range    = "10.0.0.0/18"
    pods_cidr_range     = "10.48.0.0/14"
    services_cidr_range = "10.8.0.0/20"
  }
}

variable "gke" {
  type        = object({
    name      = string
    regional  = bool
    zones     = list(string)
  })
  description = "value for GKE Cluster"

  default     = {
    name      = "gke-cluster"
    regional  = true
    zones     = [
      "us-central1-b",
      "us-central1-c",
      "us-central1-f",
    ]
  }
}

variable "node_pool" {
  type = object({
    name               = string
    machine_type       = string
    spot               = bool
    initial_node_count = number
    max_count          = number
    disk_size_gb       = number
  })
  description = "value for GKE Node Pool"

  default = {
    name               = "gke-node-pool"
    machine_type       = "e2-small"
    spot               = true
    initial_node_count = 2
    max_count          = 4
    disk_size_gb       = 10
  }
}

variable "service_account" {
  type = object({
    name  = string
    roles = list(string)
  })
  description = "Service Account for GKE"

  default = {
    name  = "registry-sa"
    roles = [ "artifactregistry.reader" ]
  }
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

variable "artifact_id" {
  type = string
  description = "ID of the Artifact Registry repository"

  default = "docker-repo"
}

variable "trigger_name" {
  type = string
  description = "ID of the Cloud Build trigger"
  
  default = "build-pyapp"
}

variable "github_repo_url" {
  type = string
  description = "URL of the GitHub repository"
}