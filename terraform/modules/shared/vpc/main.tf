data "aws_availability_zones" "available" {}

locals {
  vpc_cidr = "${var.start_cidr}.0.0/16"

  public_cidrs = [
    "${var.start_cidr}.1.0/24",
    "${var.start_cidr}.2.0/24",
    "${var.start_cidr}.3.0/24",
    "${var.start_cidr}.4.0/24",
    "${var.start_cidr}.5.0/24",
    "${var.start_cidr}.6.0/24"
    ]
  private_cidrs = [
    "${var.start_cidr}.21.0/24",
    "${var.start_cidr}.22.0/24",
    "${var.start_cidr}.23.0/24",
    ]
  database_cidrs = [
    "${var.start_cidr}.31.0/24",
    "${var.start_cidr}.32.0/24",
    "${var.start_cidr}.33.0/24",
    ]
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.env
  cidr = local.vpc_cidr

  azs = data.aws_availability_zones.available.names
  private_subnets = local.private_cidrs
  public_subnets = local.public_cidrs
  database_subnets = local.database_cidrs

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    ManagedBy = "Terraform"
    Environment = var.env
  }
}

