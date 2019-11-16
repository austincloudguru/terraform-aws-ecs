# AWS ECS Terraform Module
Terraform module that deploys an ECS autoscaling group with EFS mounted at /efs for a datastore.

## Usage
```hcl
module "ecs-0" {
  source                        = "AustinCloudGuru/ecs/aws"
  version                       = "1.1.0"
  ecs_name                      = "my-ecs-cluster"
  vpc_id                        = vpc-0e151a59f874eadd8
  ecs_cidr_block                = ["10.0.0.0/8"]
  subnet_ids                    = ["subnet-1e151a59f874eadd8", "subnet-0e148a59f874eadd8", "subnet-2e151a57f874eadd8"]
  ecs_min_size                  = "1"
  ecs_max_size                  = "3"
  ecs_desired_capacity          = "2"
  ecs_instance_type             = "t2.large"
  ecs_key_name                  = "aws-key"
  tags                          = var.tags
  ecs_additional_iam_statements = var.ecs_additional_iam_statements
  efs_id                        = "fs-532cdcd3"
  efs_sg_id                     = "sg-076487b693f21bcb8"
}
# Variables
tags = {
         Terraform = "true"
         Environment = "development"
       }

ecs_additional_iam_statements = [
  {
    effect = "Allow"
    actions = [
      "ec2:*",
      "autoscaling:*"
    ]
    resources = ["*"]
  }
]

```
   
## Variables
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_id | The VPC ID that the cluster will be deployed to| string | | yes |
| subnet_ids | The Subnet IDs that the cluster will be deployed to | list(string) | | yes |
| efs_sg_id | The EFS Security Group ID | string | "" | no |
| efs_id | The EFS ID | String | "" | no |
| ecs_name | Name for the ECS cluster that will be deployed | string | | yes | 
| ecs_cidr_block | Cider Block for the Security Group | list(string) | | yes |
| ecs_min_size | The minimum number of ECS servers to create in the autoscaling group | number | 1 | no |
| ecs_max_size | The maximuum number of ECS servers to create in the autoscaling group | number | 1 | no |
| ecs_desired_capacity | The desired number of ECS servers to create in the autoscaling group | number | 1 | no |
| ecs_instance_type | The instance type to deploy to. | string | t3.medium | no |
| ecs_key_name | The key name to use for the instances. | string | "" | no |
| ecs_associate_public_ip_address | Whether to associate a public IP in the launch configuration | bool | false | no | 
| ecs_additional_iam_statements | Additional IAM statements for the ECS instances | list(object) | [] | no |
| tags | A map of tags to add to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ECS cluster ID |
| cluster_arn | The ECS cluster ARN |

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
