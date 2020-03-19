output "security_group_name" {
  description = "The name of the security group"
  value       = element(concat(aws_security_group.this.*.name, [""]), 0)
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(aws_security_group.this.*.id, [""]), 0)
}

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = element(concat(aws_security_group.this.*.arn, [""]), 0)
}

output "cluster_arn" {
  description = "The ARN that identifies the cluster"
  value       = element(concat(aws_ecs_cluster.this.*.arn, [""]), 0)
}