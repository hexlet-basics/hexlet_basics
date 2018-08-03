resource "google_cloudbuild_trigger" "app" {
  project  = "${var.project_name}"
  description = "app"
  trigger_template {
    branch_name = "master"
    project     = "${var.project_name}"
    repo_name   = "${var.repository}"
  }
  filename = "services/app/cloudbuild.yaml"
}
