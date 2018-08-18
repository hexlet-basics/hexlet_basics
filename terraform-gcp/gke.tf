resource "google_container_cluster" "hexlet_basics" {
  min_master_version = "1.10.6-gke.1"

  # remove_default_node_pool = true
  project            = "${var.project_name}"
  name               = "${var.project_name}"
  zone               = "${var.zone}"
  initial_node_count = 1

  # additional_zones = "${var.additional_zones}"

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    machine_type = "g1-small"
    disk_size_gb = 50
  }
}

