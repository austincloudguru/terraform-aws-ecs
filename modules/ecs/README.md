# ecs
This module create an ECS cluster and a security group with no ingress and and egress to [0.0.0.0/0] (default).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_iam\_statements | Additional IAM statements for the ECS instances | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `[]` | no |
| associate\_public\_ip\_address | Whether to associate a public IP in the launch configuration | `bool` | `false` | no |
| attach\_efs | Whether to try and attach an EFS volume to the instances | `bool` | `false` | no |
| depends\_on\_efs | If attaching EFS, it makes sure that the mount targets are ready | `list(string)` | `[]` | no |
| desired\_capacity | Desired number of EC2 instances. | `number` | `1` | no |
| efs\_id | The EFS ID - Required if attach\_efs is true | `string` | `""` | no |
| efs\_sg\_id | The EFS Security Group ID - Required if attach\_efs is true | `string` | `""` | no |
| image\_id | The EC2 image ID to launch | `string` | `""` | no |
| instance\_type | Default instance type | `string` | `"t3.medium"` | no |
| key\_name | SSH key name in your AWS account for AWS instances. | `string` | `""` | no |
| managed\_termination\_protection | Enables or disables container-aware termination of instances in the auto scaling group when scale-in happens | `string` | `"ENABLED"` | no |
| max\_size | Maximum number of EC2 instances. | `number` | `1` | no |
| maximum\_scaling\_step\_size | The maximum step adjustment size. | `number` | n/a | yes |
| min\_size | Minimum number of EC2 instances. | `number` | `1` | no |
| minimum\_scaling\_step\_size | The minimum step adjustment size. | `number` | n/a | yes |
| name | The name of the ECS Cluster | `string` | `""` | no |
| status | Whether auto scaling is managed by ECS | `string` | `"ENABLED"` | no |
| subnet\_ids | The Subnet IDs | `list(string)` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| target\_capacity | The target utilization for the capacity provider | `number` | `80` | no |
| vpc\_id | The VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_arn | The ARN that identifies the cluster |
| ecs\_capacity\_provider\_arn | n/a |
| security\_group\_arn | The ARN of the security group |
| security\_group\_id | The ID of the security group |
| security\_group\_name | The name of the security group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
