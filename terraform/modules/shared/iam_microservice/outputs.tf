output "role_execution_role_arn" {
  value = aws_iam_role.microservice_task_execution_role.arn
}

output "task_role_arn" {
  value = aws_iam_role.microservice_task_role.arn
}