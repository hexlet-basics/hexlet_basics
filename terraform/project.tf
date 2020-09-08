provider "google" {
  version     = "~> 2.7"
  region      = var.region
  credentials = file("google.key.json")
}

provider "cloudflare" {
  version = "~> 1.15.0"
  email    = var.cloudflare_email
  token  = var.cloudflare_api_key
}

provider "kubernetes" {
  version = "~> 1.7"

  # region = var.region
}

resource "google_project" "hexlet_basics" {
  name            = var.project_name
  project_id      = var.project_name
  billing_account = var.billing_account
  org_id          = var.org_id
}

provider "digitalocean" {
  version = "~> 1.16.0"
  token   =  "4700689d4645fd83cd49145e4d870644f7b8d538444d537d8316261cadb099d3"
}

output "project_id" {
  value = google_project.hexlet_basics.project_id
}
