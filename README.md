# AWS ECS Terraform Module
Terraform module that deploys an ECS autoscaling group.  If you include an EFS ID and EFS Security Group, it will also mount the EFS volume to the ECS instances.  

# Deploying with EFS
By default, the module will deploy without trying to mount an EFS volume.  If you attempt to deploy the EFS at the same time as the ECS cluster, a race condition exists where the autoscaling group gets created before the mount targets have finished being created.   To avoid this, you can set the depends_on_efs variable to the aws_efs_mount_target output.  This way, the autoscaling group won't get created until the EFS mount targets have been created.

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
  attach_efs                    = true
  efs_id                        = "fs-532cdcd3"
  efs_sg_id                     = "sg-076487b693f21bcb8"
  depends_on_efs                = ["fsmt-8387e72b"]
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
| attach_efs | Whether to try and attach an EFS volume to the instances | bool | false | no
| efs_sg_id | The EFS Security Group ID  - Required if attach_efs is true | string | "" | no |
| efs_id | The EFS ID  - Required if attach_efs is true | String | "" | no |
| depends_on_efs | If attaching EFS, it makes sure that the mount targets are ready | list(string) | [] | no |
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
| container_start_timeout | Timeout in minutes allowed for a contaner to startup | string | 3m | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ECS cluster ID |
| cluster_arn | The ECS cluster ARN |

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
