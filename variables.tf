variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "subnets" {
  description = "List of Subnet ID"
  type        = list
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
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}
