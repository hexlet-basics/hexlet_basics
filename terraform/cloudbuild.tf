resource "google_cloudbuild_trigger" "app" {
  project     = "${var.project_name}"
  description = "app"

  trigger_template {
    branch_name = "master"
    project     = "${var.project_name}"
    repo_name   = "${google_sourcerepo_repository.hexlet_basics.name}"
  }

  filename = "services/app/cloudbuild.yaml"

  substitutions = {
    _SLACK_WEBHOOK = "${var.slack_codebuild_webhook}"
  }
}

resource "google_cloudbuild_trigger" "nginx" {
  project     = "${var.project_name}"
  description = "nginx"

  trigger_template {
    branch_name = "master"
    project     = "${var.project_name}"
    repo_name   = "${google_sourcerepo_repository.hexlet_basics.name}"
  }

  substitutions = {
    _SLACK_WEBHOOK = "${var.slack_codebuild_webhook}"
  }

  filename = "services/nginx/cloudbuild.yaml"
}

resource "google_cloudbuild_trigger" "exercises_php" {
  project     = "${var.project_name}"
  description = "exercises_php"

  trigger_template {
    branch_name = "master"
    project     = "${var.project_name}"
    repo_name   = "${google_sourcerepo_repository.exercises_php.name}"
  }

  substitutions = {
    _SLACK_WEBHOOK = "${var.slack_codebuild_webhook}"
  }

  filename = "cloudbuild.yaml"
}
