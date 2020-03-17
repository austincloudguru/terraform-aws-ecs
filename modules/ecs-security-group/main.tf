#------------------------------------------------------------------------------
# Create the Security Group Role
#------------------------------------------------------------------------------
resource "aws_security_group_rule" "this" {
  type                     = "ingress"
  description              = var.description
  security_group_id        = var.security_group_id
  source_security_group_id = var.source_security_group_id
  self                     = var.self
  from_port                = var.from_port
  protocol                 = var.protocol
  to_port                  = var.to_port
  cidr_blocks              = var.cidr_blocks
}
