terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../shared/vpc"
  env = var.env
  start_cidr = var.start_cidr
}

module "ecr-repos" {
  source = "../shared/ecr"
  service_names = ["stay-home"]
  env = var.env
}

