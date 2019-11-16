#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "The Subnet IDs"
  type        = list(string)
}

variable "efs_sg_id" {
  description = "The EFS Security Group ID"
  type        = string
  default     = ""
}

variable "ecs_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "ecs_cidr_block" {
  description = "ECS Cluster Name"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "ecs_min_size" {
  description = "Minimum number of EC2 instances."
  type        = number
  default     = 1
}

variable "ecs_max_size" {
  description = "Maximum number of EC2 instances."
  type        = number
  default     = 1
}

variable "ecs_desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
  default     = 1
}

variable "ecs_instance_type" {
  description = "Default instance type"
  type        = string
  default     = "t3.medium"
}

variable "ecs_key_name" {
  description = "SSH key name in your AWS account for AWS instances."
  type        = string
  default     = ""
}

variable "ecs_associate_public_ip_address" {
  description = "Whether to associate a public IP in the launch configuration"
  type        = bool
  default     = false
}

variable "ecs_additional_iam_statements" {
  description = "Additional IAM statements for the ECS instances"
  type = list(object({
    effect = string
    actions = list(string)
    resources = list(string)
  }))
  default = []
}
