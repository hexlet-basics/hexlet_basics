# resource "google_compute_instance" "web1" {
#   project  = "${var.project_name}"
#   name         = "web1"
#   machine_type = "g1-small"
#   zone         = "europe-west3-b"

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-1804-lts"
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {}
#   }

#   allow_stopping_for_update = true

#   service_account {
#     scopes = ["userinfo-email", "compute-ro", "storage-ro"]
#   }
# }

# resource "google_compute_instance_group" "webservers" {
#   project  = "${var.project_name}"
#   name        = "webservers"
#   zone         = "europe-west3-b"
#   # network     = "${google_compute_network.default.self_link}"

#   instances = [
#     "${google_compute_instance.web1.self_link}",
#   ]
# }
