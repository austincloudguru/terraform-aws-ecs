variable "vpc_id" {
  type = string
}
variable "ecs_cluster_name" {
  type = string
}

variable "subnets" {
  type = list
}

variable "min_instance_size" {
  description = "Minimum number of EC2 instances."
  default     = 1
}

variable "max_instance_size" {
  description = "Maximum number of EC2 instances."
  default     = 1
}

variable "desired_instance_capacity" {
  description = "Desired number of EC2 instances."
  default     = 1
}

variable "instance_type" {
  description = "Default instance type"
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
  default     = ""
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}
