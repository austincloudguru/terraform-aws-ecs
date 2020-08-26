# ecs
This module create an ECS cluster and a security group with no ingress and and egress to [0.0.0.0/0] (default).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6, < 0.14 |
| aws | >= 2.68, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68, < 4.0 |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_iam\_statements | Additional IAM statements for the ECS instances | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `[]` | no |
| associate\_public\_ip\_address | Whether to associate a public IP in the launch configuration | `bool` | `false` | no |
| attach\_efs | Whether to try and attach an EFS volume to the instances | `bool` | `false` | no |
| depends\_on\_efs | If attaching EFS, it makes sure that the mount targets are ready | `list(string)` | `[]` | no |
| desired\_capacity | Desired number of EC2 instances. | `number` | `1` | no |
| efs\_id | The EFS ID - Required if attach\_efs is true | `string` | `""` | no |
| efs\_sg\_id | The EFS Security Group ID - Required if attach\_efs is true | `string` | `""` | no |
| health\_check\_grace\_period | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| health\_check\_type | EC2 or ELB. Controls how health checking is done | `string` | `"EC2"` | no |
| image\_id | The EC2 image ID to launch | `string` | `""` | no |
| instance\_type | Default instance type | `string` | `"t3.medium"` | no |
| key\_name | SSH key name in your AWS account for AWS instances. | `string` | `""` | no |
| max\_size | Maximum number of EC2 instances. | `number` | `1` | no |
| min\_size | Minimum number of EC2 instances. | `number` | `1` | no |
| name | The name of the ECS Cluster | `string` | `""` | no |
| protect\_from\_scale\_in | Allows setting instance protection | `bool` | `false` | no |
| subnet\_ids | The Subnet IDs | `list(string)` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| termination\_policies | A list of policies to decide how the instances in the auto scale group should be terminated | `list(string)` | <pre>[<br>  "OldestInstance",<br>  "Default"<br>]</pre> | no |
| vpc\_id | The VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | The ARN that identifies the cluster |
| security\_group\_arn | The ARN of the security group |
| security\_group\_id | The ID of the security group |
| security\_group\_name | The name of the security group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
