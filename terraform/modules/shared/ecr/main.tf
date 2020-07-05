resource "aws_ecr_repository" "service_repo" {
  name = "${var.env}-${var.service_names[count.index]}"
  count = length(var.service_names)
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    ManagedBy = "Terraform"
    Environment = var.env
  }
}