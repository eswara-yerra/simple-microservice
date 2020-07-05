output "vpc_id" {
  value = module.vpc.vpc_id
}

#output "cert_arn" {
#  value = module.cert.cert_arn
#}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "repo_urls" {
  value = module.ecr-repos.repo_urls
}

