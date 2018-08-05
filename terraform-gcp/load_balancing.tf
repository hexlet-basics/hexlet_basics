# resource "google_compute_backend_service" "web" {
#   project  = "${var.project_name}"
#   name        = "web"
#   # description = "Our company website"
#   port_name   = "http"
#   protocol    = "HTTP"
#   timeout_sec = 10
#   enable_cdn  = false

#   backend {
#     group = "${google_compute_instance_group.webservers.self_link}"
#   }

#   health_checks = ["${google_compute_health_check.http.self_link}"]
# }

# module "gce-lb-http" {
#   source            = "GoogleCloudPlatform/lb-http/google"
#   name              = "group-http-lb"
#   target_tags       = ["${google_compute_instance_group.webservers.target_tags}"]
#   backends          = {
#     "0" = [
#       { group = "${google_compute_instance_group.webservers.self_link}" },
#     ],
#   }
#   backend_params    = [
#     # health check path, port name, port number, timeout seconds.
#     "/,http,80,10"
#   ]
# }
