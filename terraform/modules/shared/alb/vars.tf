variable env{}
variable domain{}
variable vpc_id {}
variable subnets {}
#variable cert_arn {}
variable white_list {
  default = ["0.0.0.0/0"]
}
variable egress_cidr {}