variable "security_group_id" {
  description = "The security group to apply this rule to"
  type        = string
  default     = ""
}

variable "from_port" {
  description = "The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')"
  type        = number
  default     = 80
}

variable "to_port" {
  description = "The end port (or ICMP code if protocol is 'icmp'"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number"
  type        = string
  default     = "tcp"
}

variable "cidr_blocks" {
  description = "List of CIDR blocks. Cannot be specified with source_security_group_id"
  type        = list(string)
  default     = []
}

variable "self" {
  description = "If true, the security group itself will be added as a source to this ingress rule"
  type        = bool
  default     = null
}

variable "source_security_group_id" {
  description = "The security group id to allow access to/from, depending on the type"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the rule"
  type        = string
  default     = ""
}
