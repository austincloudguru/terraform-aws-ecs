#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
variable "depends_on_efs" {
  description = "If attaching EFS, it makes sure that the mount targets are ready"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "The VPC ID that the cluster will be deployed to"
  type        = string
}

variable "subnet_ids" {
  description = "The Subnet IDs"
  type        = list(string)
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

variable "name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "cidr_block" {
  description = "ECS Cluster Name"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
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
