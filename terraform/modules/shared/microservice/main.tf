module "microservice_iam" {
  source = "../iam_microservice"
  env = var.env
  service_name = var.service_name
}

resource "aws_alb_target_group" "microservice_tg" {
  name        = "tg-${var.env}-${var.product_code}"
  #port        = var.app_port
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}

resource "aws_alb_listener_rule" "microservice_listener" {
  listener_arn = var.alb_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.microservice_tg.arn
  }

  condition {
    field  = "path-pattern"
    values = [ "/*"]
  }
}

module "ecs" {
  source = "../ecs"
  env = var.env
  ecr_repo = var.ecr_repo
  app_port = var.app_port
  product_code = var.product_code
  product_version = var.product_version
  size = var.size
  service_name = var.service_name
  role_arn = module.microservice_iam.task_role_arn
  target_group_arn =aws_alb_target_group.microservice_tg.arn
  execution_role_arn = module.microservice_iam.role_execution_role_arn
  subnets = var.subnets
  security_groups = var.security_groups
  vpc_id      = var.vpc_id
}