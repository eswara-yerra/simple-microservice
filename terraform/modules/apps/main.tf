terraform {
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "setup" {
  backend = "s3"
  config = {
    bucket = "stream-tweets"
    key    = "setup/terraform.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    bucket = "stream-tweets"
    key    = "infra/terraform.tfstate"
    region = var.aws_region
  }
}

module "stay-home" {
  source = "../shared/microservice"
  app_port = 8080
  ecr_repo = data.terraform_remote_state.setup.outputs.repo_urls["stay-home"]
  env = var.env
  product_code = var.product_code
  product_version = var.product_version
  size = var.env_size
  service_name = "stay-home"
  vpc_id = data.terraform_remote_state.setup.outputs.vpc_id
  alb_id = data.terraform_remote_state.infra.outputs.alb_id
  alb_dns_name = data.terraform_remote_state.infra.outputs.alb_dns_name
  alb_listener_arn = data.terraform_remote_state.infra.outputs.alb_http_listener_arn
  domain = var.domain
  subnets = data.terraform_remote_state.setup.outputs.public_subnets
  security_groups = data.terraform_remote_state.infra.outputs.sg_public_alb_name
}
