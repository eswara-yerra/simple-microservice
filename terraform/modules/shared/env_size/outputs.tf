output "ecs_cpu" {
  value = var.ecs_cpu[var.size]
}

output "ecs_memory" {
  value = var.ecs_memory[var.size]
}
output "ecs_desired_count" {
  value = var.ecs_desired_count[var.size]
}
