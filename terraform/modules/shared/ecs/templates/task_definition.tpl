[
  {
    "name": "${env}-${service_name}",
    "family" : "${product_code}",
    "taskRoleArn": "${role_arn}",
    "image": "${image_url}",
    "cpu": ${cpu},
    "networkMode": "awsvpc",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${env}-${service_name}",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "${env}-${service_name}",
        "awslogs-create-group": "true"
      }
    },    
    "portMappings": [
      {
      "containerPort": ${app_port},
      "hostPort": ${app_port}
      }
    ]
  }
]