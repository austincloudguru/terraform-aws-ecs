# ecs-service
This module deploys a service to an ECS cluster.

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
| [aws_ecs_service.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.main-no-lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_exec_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.instance_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.ecs_exec_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.instance_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_policy_document.ecs_exec_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_exec_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.instance_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.task_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_deploy_with_tg"></a> [deploy\_with\_tg](#input\_deploy\_with\_tg) | Deploy the service group attached to a target group | `bool` | `false` | no |
| <a name="input_ecs_cluster_id"></a> [ecs\_cluster\_id](#input\_ecs\_cluster\_id) | ID of the ECS cluster | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environmental Variables to pass to the container | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | Whether the task is essential | `bool` | `true` | no |
| <a name="input_exec_iam_policies"></a> [exec\_iam\_policies](#input\_exec\_iam\_policies) | Additional IAM policies for the task | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Name of the image to be deployed | `string` | n/a | yes |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | Additional Linux Parameters | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>  })</pre> | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | Log configuration options to send to a custom log driver for the container. | <pre>object({<br>    logDriver = string<br>    options   = map(string)<br>    secretOptions = list(object({<br>      name      = string<br>      valueFrom = string<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_memory_reservation"></a> [memory\_reservation](#input\_memory\_reservation) | Soft Memory to Allocate | `number` | `512` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Mount points for the container | <pre>list(object({<br>    containerPath = string<br>    sourceVolume  = string<br>    readOnly      = bool<br>  }))</pre> | `[]` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The Network Mode to run the container at | `string` | `"bridge"` | no |
| <a name="input_port_mappings"></a> [port\_mappings](#input\_port\_mappings) | Port mappings for the docker Container | <pre>list(object({<br>    hostPort      = number<br>    containerPort = number<br>    protocol      = string<br>  }))</pre> | `[]` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | Whether the task is privileged | `bool` | `false` | no |
| <a name="input_repository_credentials"></a> [repository\_credentials](#input\_repository\_credentials) | Container repository credentials for using private repos.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret | `map(string)` | `null` | no |
| <a name="input_scheduling_strategy"></a> [scheduling\_strategy](#input\_scheduling\_strategy) | The scheduling strategy to use for the service | `string` | `"REPLICA"` | no |
| <a name="input_service_cpu"></a> [service\_cpu](#input\_service\_cpu) | CPU Units to Allocation | `number` | `128` | no |
| <a name="input_service_desired_count"></a> [service\_desired\_count](#input\_service\_desired\_count) | Desired Number of Instances to run | `number` | `1` | no |
| <a name="input_service_memory"></a> [service\_memory](#input\_service\_memory) | Hard memory to allocate | `number` | `null` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of the service being deployed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the Load Balancer target group to associate with the service. | `string` | `null` | no |
| <a name="input_task_iam_policies"></a> [task\_iam\_policies](#input\_task\_iam\_policies) | Additional IAM policies for the task | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_tld"></a> [tld](#input\_tld) | Top Level Domain to use | `string` | `""` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | A list of ulimits to set in the container. | <pre>list(object({<br>    Name      = string<br>    HardLimit = number<br>    SoftLimit = number<br>  }))</pre> | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | Task volume definitions as list of configuration objects | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
