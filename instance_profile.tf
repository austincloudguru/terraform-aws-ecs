#------------------------------------------------------------------------------
# Create an Instance Profile
#------------------------------------------------------------------------------
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.ecs_cluster_name}-ecs-instance_profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name               = "${var.ecs_cluster_name}-ecs-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "role_policy" {
  name   = "jenkins-ecs-policy"
  role   = aws_iam_role.role.id
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
