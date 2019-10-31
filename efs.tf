#------------------------------------------------------------------------------
# Create the EFS for Jenkins
#------------------------------------------------------------------------------
resource "aws_security_group" "ecs_efs_sg" {
  name        = "${var.ecs_cluster_name}-efs-sg"
  description = "Allows NFS Traffic for ${var.ecs_cluster_name}"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 2049
    protocol  = "tcp"
    to_port   = 2049
    self      = true
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "ecs_efs" {
  creation_token = "${var.ecs_cluster_name}-efs"

  tags = {
    Name = "${var.ecs_cluster_name}-efs"
  }
}


resource "aws_efs_mount_target" "ecs_efs_mount_target_0" {
  file_system_id = aws_efs_file_system.ecs_efs.id
  subnet_id      = var.subnet_id_0
  security_groups = [
    aws_security_group.ecs_efs_sg.id
  ]
}

resource "aws_efs_mount_target" "ecs_efs_mount_target_1" {
  file_system_id = aws_efs_file_system.ecs_efs.id
  subnet_id      = var.subnet_id_1
  security_groups = [
    aws_security_group.ecs_efs_sg.id
  ]
}

resource "aws_efs_mount_target" "ecs_efs_mount_target_2" {
  file_system_id = aws_efs_file_system.ecs_efs.id
  subnet_id      = var.subnet_id_2
  security_groups = [
    aws_security_group.ecs_efs_sg.id
  ]
}
