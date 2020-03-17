variable "name" {
  description = "The name of the ECS Cluster"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "The Subnet IDs"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "attach_efs" {
  description = "Whether to try and attach an EFS volume to the instances"
  type        = bool
  default     = false
}

variable "efs_sg_id" {
  description = "The EFS Security Group ID - Required if attach_efs is true"
  type        = string
  default     = ""
}

variable "efs_id" {
  description = "The EFS ID - Required if attach_efs is true"
  type        = string
  default     = ""
}

variable "depends_on_efs" {
  description = "If attaching EFS, it makes sure that the mount targets are ready"
  type        = list(string)
  default     = []
}

variable "managed_termination_protection" {
  description = " Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens"
  type        = string
  default     = "DISABLED"
}

variable "minimum_scaling_step_size" {
  description = "The minimum step adjustment size."
  type        = number
  default     = null
}

variable "maximum_scaling_step_size" {
  description = "The maximum step adjustment size."
  type        = number
  default     = null
}

variable "status" {
  description = "Whether auto scaling is managed by ECS"
  type        = string
  default     = "ENABLED"
}

variable "target_capacity" {
  description = "The target utilization for the capacity provider"
  type        = number
  default     = 80
}

variable "min_size" {
  description = "Minimum number of EC2 instances."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances."
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Default instance type"
  type        = string
  default     = "t3.medium"
}

variable "image_id" {
  description = "The EC2 image ID to launch"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "SSH key name in your AWS account for AWS instances."
  type        = string
  default     = ""
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP in the launch configuration"
  type        = bool
  default     = false
}

variable "additional_iam_statements" {
  description = "Additional IAM statements for the ECS instances"
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}

variable "health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  type        = string
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
  type        = list(string)
  default     = ["OldestInstance", "Default"]
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection"
  type        = bool
  default     = false
}
