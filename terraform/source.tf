resource "google_sourcerepo_repository" "exercises_php" {
  project = "${var.project_name}"
  name = "hexlet-basics-exercises_php"
}

resource "google_sourcerepo_repository" "hexlet_basics" {
  project = "${var.project_name}"
  name = "hexlet-basics-hexlet_basics"
}

