#------------------------------------------------------------------------------
# Create the Security Group
#------------------------------------------------------------------------------
resource "aws_security_group" "this" {
  name        = join("", [var.name, "-ecs"])
  description = join(" ", ["Security Group for", var.name, "ecs"])
  vpc_id      = var.vpc_id
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = 0
  protocol          = "-1"
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

#------------------------------------------------------------------------------
# Create the Userdata Templates
#------------------------------------------------------------------------------
locals {
  userdata = templatefile("${path.module}/files//user_data.tpl",
    {
      attach_efs       = var.attach_efs
      ecs_cluster_name = aws_ecs_cluster.this.name
      efs_id           = var.efs_id
      depends_on       = join("", var.depends_on_efs)
    }
  )
}

#------------------------------------------------------------------------------
# Create the ECS Cluster
#------------------------------------------------------------------------------
resource "aws_ecs_cluster" "this" {
  name = var.name
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

#------------------------------------------------------------------------------
# Create the Autoscaling Group
#------------------------------------------------------------------------------
locals {
  asg_tags = merge(
    { "Name" = var.name },
    var.tags
  )
  # tags_asg_format = null_resource.tags_as_list_of_maps.*.triggers
}

# resource "null_resource" "tags_as_list_of_maps" {
#   count = length(keys(var.tags))

#   triggers = {
#     "key"                 = keys(var.tags)[count.index]
#     "value"               = values(var.tags)[count.index]
#     "propagate_at_launch" = "true"
#   }
#}

resource "aws_autoscaling_group" "this" {
  name                      = var.name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  termination_policies      = var.termination_policies
  vpc_zone_identifier       = var.subnet_ids
  launch_configuration      = aws_launch_configuration.this.name
  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = local.asg_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_launch_configuration" "this" {
  name_prefix                 = join("", [var.name, "-"])
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = (length(var.efs_sg_id) > 0 ? [aws_security_group.this.id, var.efs_sg_id] : [aws_security_group.this.id])
  iam_instance_profile        = aws_iam_instance_profile.this.name
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = local.userdata

  lifecycle {
    create_before_destroy = true
  }
}

#------------------------------------------------------------------------------
# Create the Instance Profile
#------------------------------------------------------------------------------
resource "aws_iam_instance_profile" "this" {
  name = var.name
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name               = var.name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_iam_role_policy" "this" {
  name   = var.name
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.policy.json
}

data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecs:StartTask",
      "ecs:ListClusters",
      "ecs:DescribeClusters",
      "ecs:RegisterTaskDefinition",
      "ecs:RunTask",
      "ecs:StopTask",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = var.additional_iam_statements
    content {
      effect    = lookup(statement.value, "effect", null)
      actions   = lookup(statement.value, "actions", null)
      resources = lookup(statement.value, "resources", null)
    }
  }

}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com",
        "ec2.amazonaws.com"
      ]
    }
  }
}
