data "aws_iam_policy_document" "microservice_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "microservice_task_role" {
  name = "${var.env}-${var.service_name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.microservice_role_policy.json
}


data "aws_iam_policy_document" "microservice_task_exe_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "microservice_task_execution_role" {
  name = "${var.env}-${var.service_name}-ecs-task-execution-role"
  #assume_role_policy = data.aws_iam_policy_document.microservice_task_exe_role_policy.json
  assume_role_policy = data.aws_iam_policy_document.microservice_role_policy.json
}

resource "aws_iam_role_policy_attachment" "microservice_task_execution_policy" {
  role       = aws_iam_role.microservice_task_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_log_policy" {
  role       = aws_iam_role.microservice_task_execution_role.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
