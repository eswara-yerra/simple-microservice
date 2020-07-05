output "alb_id" {
  value = module.alb.alb_id
}
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
#output "alb_https_listener_arn" {
#  value = module.alb.alb_https_listener_arn
#}
output "alb_http_listener_arn"{
  value = module.alb.alb_http_listener_arn
}

output "sg_public_alb_name"{
  value = module.alb.sg_public_alb_name
}
