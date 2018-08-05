resource "google_container_cluster" "hexlet_basics" {
  min_master_version  = "1.10.5-gke.3"
  # remove_default_node_pool = true
  project  = "${var.project_name}"
  name               = "${var.project_name}"
  zone               = "${var.zone}"
  initial_node_count = 1

  additional_zones = "${var.additional_zones}"

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

resource "kubernetes_secret" "cloudsql_db_credentials" {
   "metadata" {
       name = "cloudsql-db-credentials"
   }

   data {
       username = "${var.db_username}"
       password = "${var.db_password}"
   }
 }

resource "kubernetes_secret" "cloudsql_instance_credentials" {
	metadata {
		name = "cloudsql-instance-credentials"
	}
	data {
		credentials.json = "${base64decode(google_service_account_key.cloudsql_proxy.private_key)}"
	}
}

