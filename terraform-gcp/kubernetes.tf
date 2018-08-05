# resource "google_container_node_pool" "web" {
#   project  = "${var.project_name}"
#   name       = "web"
#   zone       = "${var.zone}"
#   cluster    = "${google_container_cluster.hexlet_basics.name}"
#   node_count = 1

#   node_config {
#     machine_type = "g1-small"

#     oauth_scopes = [
#       "compute-rw",
#       "storage-ro",
#       "logging-write",
#       "monitoring",
#     ]
#   }
# }

resource "google_container_cluster" "hexlet_basics" {
  min_master_version  = "1.10.5-gke.3"
  # remove_default_node_pool = true
  project  = "${var.project_name}"
  name               = "${var.project_name}"
  zone               = "${var.zone}"
  initial_node_count = 1

  additional_zones = "${var.additional_zones}"

  # node_pool {
  #   name = "web"
  # }


  # master_auth {
  #   username = "mr.yoda"
  #   password = "adoy.rm"
  # }

  # node_config {
  #   oauth_scopes = [
  #     "https://www.googleapis.com/auth/compute",
  #     "https://www.googleapis.com/auth/devstorage.read_only",
  #     "https://www.googleapis.com/auth/logging.write",
  #     "https://www.googleapis.com/auth/monitoring",
  #   ]

    # labels {
    #   foo = "bar"
    # }

    # tags = ["foo", "bar"]
  # }
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
# output "client_certificate" {
#   value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
# }

# output "client_key" {
#   value = "${google_container_cluster.primary.master_auth.0.client_key}"
# }

# output "cluster_ca_certificate" {
#   value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
# }
