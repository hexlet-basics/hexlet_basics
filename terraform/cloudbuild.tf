resource "google_cloudbuild_trigger" "app" {
  project     = "${var.project_name}"
  description = "app"

  trigger_template {
    branch_name = "master"
    project     = "${var.project_name}"
    repo_name   = "${var.repository}"
  }

  filename = "services/app/cloudbuild.yaml"

  # substitutions = {
  # _SLACK_WEBHOOK = "${var.slack_codebuild_webhook}"
  # }
}

resource "google_cloudbuild_trigger" "nginx" {
  project     = "${var.project_name}"
  description = "nginx"

  trigger_template {
    branch_name = "master"
    project     = "${var.project_name}"
    repo_name   = "${var.repository}"
  }

  filename = "services/nginx/cloudbuild.yaml"
}
