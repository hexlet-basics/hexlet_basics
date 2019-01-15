terraform {
  backend "gcs" {
    bucket  = "hexlet-basics-terraform-state"
    prefix  = "production"
    project = "hexlet-basics"
    credentials = "google.key.json"
  }
}
