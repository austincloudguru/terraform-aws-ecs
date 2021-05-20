#------------------------------------------------------------------------------
# Variables for ECS Service Module
#------------------------------------------------------------------------------
variable "service_name" {
  description = "Name of the service being deployed"
  type        = string
}

variable "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  type        = string
}

variable "service_desired_count" {
  description = "Desired Number of Instances to run"
  type        = number
  default     = 1
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "task_iam_policies" {
  description = "Additional IAM policies for the task"
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default = null
}

variable "exec_iam_policies" {
  description = "Additional IAM policies for the task"
  type = list(object({
    effect    = string
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}

variable "image_name" {
  description = "Name of the image to be deployed"
  type        = string
}

variable "service_cpu" {
  description = "CPU Units to Allocation"
  type        = number
  default     = 128
}

variable "service_memory" {
  description = "Hard memory to allocate"
  type        = number
  default     = null
}

variable "memory_reservation" {
  description = "Soft Memory to Allocate"
  type        = number
  default     = 512
}

variable "essential" {
  description = "Whether the task is essential"
  type        = bool
  default     = true
}

variable "privileged" {
  description = "Whether the task is privileged"
  type        = bool
  default     = false
}

variable "command" {
  description = "The command that is passed to the container"
  type        = list(string)
  default     = []
}

variable "port_mappings" {
  description = "Port mappings for the docker Container"
  type = list(object({
    hostPort      = number
    containerPort = number
    protocol      = string
  }))
  default = []
}

variable "mount_points" {
  description = "Mount points for the container"
  type = list(object({
    containerPath = string
    sourceVolume  = string
    readOnly      = bool
  }))
  default = []
}

variable "environment" {
  description = "Environmental Variables to pass to the container"
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}

variable "linux_parameters" {
  description = "Additional Linux Parameters"
  type = object({
    capabilities = object({
      add  = list(string)
      drop = list(string)
    })
  })
  default = null
}

variable "network_mode" {
  description = "The Network Mode to run the container at"
  type        = string
  default     = "bridge"
}

variable "volumes" {
  description = "Task volume definitions as list of configuration objects"
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
  }))
  default = []
}

variable "tld" {
  description = "Top Level Domain to use"
  type        = string
  default     = ""
}

variable "log_configuration" {
  description = "Log configuration options to send to a custom log driver for the container."
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = list(object({
      name      = string
      valueFrom = string
    }))
  })
  default = null
}

variable "deploy_with_tg" {
  description = "Deploy the service group attached to a target group"
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "The ARN of the Load Balancer target group to associate with the service."
  type        = string
  default     = null
}

variable "scheduling_strategy" {
  description = "The scheduling strategy to use for the service"
  type        = string
  default     = "REPLICA"
}

variable "ulimits" {
  description = "A list of ulimits to set in the container."
  type = list(object({
    Name      = string
    HardLimit = number
    SoftLimit = number
  }))
  default = null
}

variable "repository_credentials" {
  description = "Container repository credentials for using private repos.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret"
  type        = map(string)
  default     = null
}
