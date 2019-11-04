#------------------------------------------------------------------------------
# Create ECS Cluster
#------------------------------------------------------------------------------
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

data "aws_ami" "latest_ecs" {
  most_recent = true
  owners      = ["591542846629"] # AWS

  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.ecs_cluster_name}-ecs-sg"
  description = "Security Group for Jenkins on ECS"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["10.172.0.0/16"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "${var.ecs_cluster_name}-ecs-asg"
  min_size                  = var.min_instance_size
  max_size                  = var.max_instance_size
  desired_capacity          = var.desired_instance_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       =  var.subnets
  launch_configuration = aws_launch_configuration.ecs_lc.name
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.ecs_cluster_name}-ecs-asg"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "ecs_lc" {
  name_prefix                 = "${var.ecs_cluster_name}-lc-"
  image_id                    = data.aws_ami.latest_ecs.image_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ecs_sg.id, aws_security_group.ecs_efs_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.instance_profile.name
  key_name                    = var.key_name
  associate_public_ip_address = false
  user_data                   = data.template_file.user_data.rendered
  depends_on                  = [aws_efs_mount_target.ecs_efs_mount_target]

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tpl")

  vars = {
    ecs_cluster_name = aws_ecs_cluster.ecs_cluster.name
    efs_id           = aws_efs_file_system.ecs_efs.id
    region           = var.aws_region
  }
}

