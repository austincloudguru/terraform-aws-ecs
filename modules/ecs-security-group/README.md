# ecs-security-group
This module creates security group ingress rules for the ECS cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6, < 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.68, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.68, < 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_blocks"></a> [cidr\_blocks](#input\_cidr\_blocks) | List of CIDR blocks. Cannot be specified with source\_security\_group\_id | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the rule | `string` | `""` | no |
| <a name="input_from_port"></a> [from\_port](#input\_from\_port) | The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6') | `number` | `80` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol. If not icmp, icmpv6, tcp, udp, or all use the protocol number | `string` | `"tcp"` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The security group to apply this rule to | `string` | `""` | no |
| <a name="input_self"></a> [self](#input\_self) | If true, the security group itself will be added as a source to this ingress rule | `bool` | `null` | no |
| <a name="input_source_security_group_id"></a> [source\_security\_group\_id](#input\_source\_security\_group\_id) | The security group id to allow access to/from, depending on the type | `string` | `""` | no |
| <a name="input_to_port"></a> [to\_port](#input\_to\_port) | The end port (or ICMP code if protocol is 'icmp' | `number` | `80` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
