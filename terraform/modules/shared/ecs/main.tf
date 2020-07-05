module "env_size" {
  source = "../env_size"
  size = var.size
}

resource "aws_ecs_cluster" "service_cluster" {
  name = "${var.env}-${var.service_name}-cluster"
}

data "template_file" "ecs_task_definition" {
  template = "${file("${path.module}/templates/task_definition.tpl")}"
  vars = {
    env = var.env,
    service_name = var.service_name,
    product_code = var.product_code,
    role_arn = var.role_arn
    image_url = "${var.ecr_repo}:${var.product_version}"
    cpu = module.env_size.ecs_cpu
    memory = module.env_size.ecs_memory
    app_port = var.app_port

  }
}

resource "aws_ecs_task_definition" "service_definition" {
  family = "app"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = module.env_size.ecs_cpu
  memory = module.env_size.ecs_memory
  execution_role_arn = var.execution_role_arn
  container_definitions = data.template_file.ecs_task_definition.rendered
}

resource "aws_security_group" "sg-service" {
  name = "service-sg"
  description = "Public Application ALB SG"
  vpc_id = var.vpc_id

  ingress {
    description = "Inbound HTTP"
    from_port = 80
    to_port = 8080
    protocol = "TCP"
    #cidr_blocks = [ var.security_groups ]
    security_groups = [ var.security_groups ]
  }

  egress {
    description = "Downstream VPC Access"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Downstream HTTPS Access"
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
    ManagedBy = "Terraform"
    Environment = var.env
  }
}


resource "aws_ecs_service" "app_service" {
  name = "${var.env}-${var.service_name}"
  cluster = aws_ecs_cluster.service_cluster.id
  task_definition = aws_ecs_task_definition.service_definition.arn
  launch_type = "FARGATE"
  desired_count = module.env_size.ecs_desired_count
  #iam_role = var.execution_role_arn
  depends_on = [
    aws_ecs_cluster.service_cluster,
    aws_security_group.sg-service,
    aws_ecs_task_definition.service_definition]

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name = "${var.env}-${var.service_name}"
    container_port = var.app_port
  }
  
  network_configuration {
    security_groups = [ aws_security_group.sg-service.id ]
    subnets         = var.subnets
    assign_public_ip = true
  }
}
