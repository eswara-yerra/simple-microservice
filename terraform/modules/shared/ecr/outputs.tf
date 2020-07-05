output "repo_urls" {
  value = zipmap(var.service_names, aws_ecr_repository.service_repo.*.repository_url)
}