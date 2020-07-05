locals {
  name = "${var.env}-public"
}

resource "aws_security_group" "sg-public-alb" {
  name = "${local.name}-sg"
  description = "Public Application ALB SG"
  vpc_id = var.vpc_id

  ingress {
    description = "Inbound HTTP"
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = var.white_list
    self = true
  }

  egress {
    description = "Downstream VPC Access"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.white_list
    self = true
  }

  tags = {
    Name = "${local.name}-sg"
    ManagedBy = "Terraform"
    Environment = var.env
  }
}

module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = local.name
  load_balancer_type = "application"
  vpc_id = var.vpc_id
  subnets = var.subnets
  security_groups = [ aws_security_group.sg-public-alb.id ]

  #access_logs = {
  #  bucket = "stream-tweets"
  #  prefix = "alblogs"
  #}

  http_tcp_listeners = [
    {
      port = 80
      protocol = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    {
      name_prefix = "dummy-"
      backend_protocol = "HTTP"
      backend_port = 80
    }
  ]
  tags = {
    ManagedBy = "Terraform"
    Environment = var.env
  }
}
