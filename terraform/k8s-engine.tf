resource "google_container_cluster" "primary" {
  name                     = var.gke.name
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.self_link
  subnetwork               = google_compute_subnetwork.this.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  # Optional, if multi-zonal cluster
  # node_locations = [
  #   "us-central1-b"
  # ]

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "cloud-ops-44.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.network.subnetwork_name}-pod-range"
    services_secondary_range_name = "${var.network.subnetwork_name}-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  
}
