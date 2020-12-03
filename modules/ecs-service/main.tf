#------------------------------------------------------------------------------
# Create the executor role
#------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_exec_role" {
  name               = join("", [var.service_name, "-exec"])
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_exec_assume_role_policy.json
  tags = merge(
    {
      "Name" = join("", [var.service_name, "-exec"])
    },
    var.tags
  )
}

resource "aws_iam_role_policy" "ecs_exec_role_policy" {
  name   = join("", [var.service_name, "-exec"])
  role   = aws_iam_role.ecs_exec_role.id
  policy = data.aws_iam_policy_document.ecs_exec_policy.json
}

data "aws_iam_policy_document" "ecs_exec_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_exec_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

#------------------------------------------------------------------------------
# Create the iam role
#------------------------------------------------------------------------------
resource "aws_iam_role" "instance_role" {
  count              = var.deploy_with_tg ? 1 : 0
  name               = join("", [var.service_name, "-svc"])
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy[0].json
  tags = merge(
    {
      "Name" = join("", [var.service_name, "-svc"])
    },
    var.tags
  )
}

resource "aws_iam_role_policy" "instance_role_policy" {
  count  = var.deploy_with_tg ? 1 : 0
  name   = join("", [var.service_name, "-svc"])
  role   = aws_iam_role.instance_role[0].id
  policy = data.aws_iam_policy_document.role_policy[0].json
}

data "aws_iam_policy_document" "role_policy" {
  count = var.deploy_with_tg ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "instance_assume_role_policy" {
  count = var.deploy_with_tg ? 1 : 0
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}

#------------------------------------------------------------------------------
# Create the task profile
#------------------------------------------------------------------------------
resource "aws_iam_role" "task_role" {
  count              = var.task_iam_policies == null ? 0 : 1
  name               = join("", [var.service_name, "-task"])
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy[0].json
  tags = merge(
  {
    "Name" = join("", [var.service_name, "-task"])
  },
  var.tags
  )
}

resource "aws_iam_role_policy" "task_role_policy" {
  count  = var.task_iam_policies == null ? 0 : 1
  name   = join("", [var.service_name, "-task"])
  role   = aws_iam_role.task_role[0].id
  policy = data.aws_iam_policy_document.role_policy[0].json
}

data "aws_iam_policy_document" "role_policy" {
  count = var.task_iam_policies == null ? 0 : 1
  dynamic "statement" {
    for_each = var.task_iam_policies
    content {
      effect    = lookup(statement.value, "effect", null)
      actions   = lookup(statement.value, "actions", null)
      resources = lookup(statement.value, "resources", null)
    }
  }
}

data "aws_iam_policy_document" "task_assume_role_policy" {
  count = var.task_iam_policies == null ? 0 : 1
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}

#------------------------------------------------------------------------------
# Launch Docker Service
#------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "this" {
  family             = var.service_name
  execution_role_arn = aws_iam_role.ecs_exec_role.arn
  task_role_arn      = aws_iam_role.task_role[0].arn
  network_mode       = var.network_mode
  container_definitions = jsonencode([
    {
      name              = var.service_name
      image             = var.image_name
      cpu               = var.service_cpu
      memory            = var.service_memory
      memoryReservation = var.memory_reservation
      essential         = var.essential
      privileged        = var.privileged
      command           = var.command
      portMappings      = var.port_mappings
      mountPoints       = var.mount_points
      environment       = var.environment
      linuxParameters   = var.linux_parameters
      logConfiguration  = var.log_configuration
      ulimits           = var.ulimits
    }
  ])
  dynamic "volume" {
    for_each = var.volumes
    content {
      name      = volume.value.name
      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = lookup(volume.value, "docker_volume_configuration", [])
        content {
          autoprovision = lookup(docker_volume_configuration.value, "autoprovision", null)
          driver        = lookup(docker_volume_configuration.value, "driver", null)
          driver_opts   = lookup(docker_volume_configuration.value, "driver_opts", null)
          labels        = lookup(docker_volume_configuration.value, "labels", null)
          scope         = lookup(docker_volume_configuration.value, "scope", null)
        }
      }
    }
  }
  tags = merge(
    {
      "Name" = var.service_name
    },
    var.tags
  )
}

resource "aws_ecs_service" "main" {
  count               = var.deploy_with_tg ? 1 : 0
  name                = var.service_name
  task_definition     = aws_ecs_task_definition.this.arn
  cluster             = var.ecs_cluster_id
  desired_count       = var.service_desired_count
  iam_role            = aws_iam_role.instance_role[0].arn
  scheduling_strategy = var.scheduling_strategy
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.service_name
    container_port   = lookup(var.port_mappings[0], "containerPort")
  }
}

resource "aws_ecs_service" "main-no-lb" {
  count               = var.deploy_with_tg ? 0 : 1
  name                = var.service_name
  task_definition     = aws_ecs_task_definition.this.arn
  cluster             = var.ecs_cluster_id
  desired_count       = var.service_desired_count
  scheduling_strategy = var.scheduling_strategy
}
