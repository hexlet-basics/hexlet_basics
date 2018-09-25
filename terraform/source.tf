resource "google_sourcerepo_repository" "exercises_php" {
  project = "${var.project_name}"
  name = "exercises_php"
}

resource "google_sourcerepo_repository" "exercises_javascript" {
  project = "${var.project_name}"
  name = "exercises_javascript"
}

resource "google_sourcerepo_repository" "exercises_python" {
  project = "${var.project_name}"
  name = "exercises_python"
}

resource "google_sourcerepo_repository" "hexlet_basics" {
  project = "${var.project_name}"
  name = "hexlet_basics"
}

