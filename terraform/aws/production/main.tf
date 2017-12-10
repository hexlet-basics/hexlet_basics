provider "aws" {
	version = "~> 1.5"
	region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "hexlet-basics-infrastructure"
    key    = "terraform"
    region = "eu-central-1"
  }
}
