variable "project_name" {
  default = "hexlet-basics"
}
variable "billing_account" {
  default = "01730C-0A5BE7-686C51"
}
variable "org_id" {
  default = "431020544079"
}
variable "region" {
  default = "europe-west3"
}

variable "repository" {
  default = "github-hexlet-basics-hexlet_basics"
}

provider "google" {
 region = "${var.region}"
}

/* resource "random_id" "id" { */
/*  byte_length = 4 */
/*  prefix      = "${var.project_name}-" */
/* } */

resource "google_project" "hexlet_basics" {
 name            = "${var.project_name}"
 project_id      = "${var.project_name}"
 billing_account = "${var.billing_account}"
 org_id          = "${var.org_id}"
}

/* resource "google_project_services" "project" { */
/*  project = "${google_project.hexlet_basics.project_id}" */
/*  services = [ */
/*    "compute.googleapis.com" */
/*  ] */
/* } */

output "project_id" {
 value = "${google_project.hexlet_basics.project_id}"
}
