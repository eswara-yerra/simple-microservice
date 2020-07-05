output "alb_id" {
  value = module.alb.this_lb_id
}

output "alb_dns_name" {
  value = module.alb.this_lb_dns_name
}

output "alb_http_listener_arn"{
  value = module.alb.http_tcp_listener_arns[0]
}

output "sg_public_alb_name"{
  value = aws_security_group.sg-public-alb.id
}
