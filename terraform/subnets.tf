resource "google_compute_subnetwork" "this" {
  name                     = var.network.subnetwork_name
  ip_cidr_range            = var.network.nodes_cidr_range
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "${var.network.subnetwork_name}-pod-range"
    ip_cidr_range = var.network.pods_cidr_range
  }
  secondary_ip_range {
    range_name    = "${var.network.subnetwork_name}-service-range"
    ip_cidr_range = var.network.services_cidr_range
  }

  lifecycle {
    ignore_changes = [
      secondary_ip_range,
      ip_cidr_range,
    ]
  }
}
