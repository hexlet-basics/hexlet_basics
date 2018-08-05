# resource "google_compute_health_check" "http" {
#   project  = "${var.project_name}"
# 	name = "http"

# 	timeout_sec        = 1
# 	check_interval_sec = 5

# 	tcp_health_check {
# 		port = "80"
# 	}
# }
