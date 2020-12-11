# ecs-service
This module deploys a service to an ECS cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6, < 0.15 |
| aws | >= 2.68, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68, < 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| command | The command that is passed to the container | `list(string)` | `[]` | no |
| deploy\_with\_tg | Deploy the service group attached to a target group | `bool` | `false` | no |
| ecs\_cluster\_id | ID of the ECS cluster | `string` | n/a | yes |
| environment | Environmental Variables to pass to the container | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| essential | Whether the task is essential | `bool` | `true` | no |
| image\_name | Name of the image to be deployed | `string` | n/a | yes |
| linux\_parameters | Additional Linux Parameters | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>  })</pre> | `null` | no |
| log\_configuration | Log configuration options to send to a custom log driver for the container. | <pre>object({<br>    logDriver = string<br>    options   = map(string)<br>    secretOptions = list(object({<br>      name      = string<br>      valueFrom = string<br>    }))<br>  })</pre> | `null` | no |
| memory\_reservation | Soft Memory to Allocate | `number` | `512` | no |
| mount\_points | Mount points for the container | <pre>list(object({<br>    containerPath = string<br>    sourceVolume  = string<br>    readOnly      = bool<br>  }))</pre> | `[]` | no |
| network\_mode | The Network Mode to run the container at | `string` | `"bridge"` | no |
| port\_mappings | Port mappings for the docker Container | <pre>list(object({<br>    hostPort      = number<br>    containerPort = number<br>    protocol      = string<br>  }))</pre> | `[]` | no |
| privileged | Whether the task is privileged | `bool` | `false` | no |
| scheduling\_strategy | The scheduling strategy to use for the service | `string` | `"REPLICA"` | no |
| service\_cpu | CPU Units to Allocation | `number` | `128` | no |
| service\_desired\_count | Desired Number of Instances to run | `number` | `1` | no |
| service\_memory | Hard memory to allocate | `number` | `null` | no |
| service\_name | Name of the service being deployed | `string` | n/a | yes |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| target\_group\_arn | The ARN of the Load Balancer target group to associate with the service. | `string` | `null` | no |
| task\_iam\_policies | Additional IAM policies for the task | <pre>list(object({<br>    effect    = string<br>    actions   = list(string)<br>    resources = list(string)<br>  }))</pre> | `null` | no |
| tld | Top Level Domain to use | `string` | `""` | no |
| ulimits | A list of ulimits to set in the container. | <pre>list(object({<br>    Name      = string<br>    HardLimit = number<br>    SoftLimit = number<br>  }))</pre> | `null` | no |
| volumes | Task volume definitions as list of configuration objects | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
