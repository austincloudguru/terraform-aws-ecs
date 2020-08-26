# ecs-security-group
This module creates security group ingress rules for the ECS cluster.

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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_blocks | List of CIDR blocks. Cannot be specified with source\_security\_group\_id | `list(string)` | `[]` | no |
| description | Description of the rule | `string` | `""` | no |
| from\_port | The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6') | `number` | `80` | no |
| protocol | The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"tcp"` | no |
| security\_group\_id | The security group to apply this rule to | `string` | `""` | no |
| self | If true, the security group itself will be added as a source to this ingress rule | `bool` | `null` | no |
| source\_security\_group\_id | The security group id to allow access to/from, depending on the type | `string` | `""` | no |
| to\_port | The end port (or ICMP code if protocol is 'icmp' | `number` | `80` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
