resource "google_container_cluster" "hexlet_basics" {
  min_master_version = "1.11.5-gke.4"

  # remove_default_node_pool = true
  project            = "${var.project_name}"
  name               = "${var.gke_cluster_name}"
  zone               = "${var.zone}"
  initial_node_count = 1

  # additional_zones = "${var.additional_zones}"

  # node_pool {
  #   management {
  #     auto_repair = true
  #   }
  # }
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/ndev.clouddns.readwrite",
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    machine_type = "n1-standard-1"
    disk_size_gb = 50
    disk_type    = "pd-ssd"
  }
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials --region ${var.zone} ${var.gke_cluster_name}"
  }
}
