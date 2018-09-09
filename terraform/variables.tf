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

variable "db_name" {}
variable "db_username" {}
variable "db_password" {}
variable "github_oauth_token" {}
variable "cloudflare_api_key" {}
variable "cloudflare_email" {}
variable "github_client_id" {}
variable "github_client_secret" {}
variable "secret_key_base" {}
variable "slack_codebuild_webhook" {}
