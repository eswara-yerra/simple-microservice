variable "ecs_cpu" {
  type = map

  default = {
    xsmall = "256"
    small = "512"
    medium = "1024"
    large = "2048"
    xlarge = "4096"
  }
}

variable "ecs_memory" {
  type = map

  default = {
    xsmall = "2GB"
    small = "4GB"
    medium = "8GB"
    large = "16GB"
    xlarge = "300GB"
  }
}

variable "ecs_desired_count" {
  type = map

  default = {
    xsmall = 1
    small = 2
    medium = 3
    large = 4
    xlarge = 5
  }
}