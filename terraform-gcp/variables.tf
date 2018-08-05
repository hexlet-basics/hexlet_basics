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
variable "zone" {
  default = "europe-west3-b"
}
variable "additional_zones" {
  default = ["europe-west3-a", "europe-west3-c"]
}
variable "repository" {
  default = "github-hexlet-basics-hexlet_basics"
}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "github_oauth_token" {}
