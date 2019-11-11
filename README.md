# AWS ECS Terraform Module
Terraform module that deploys an ECS autoscaling group with EFS mounted at /efa for a datastore.

## Usage
```hcl
module "ecs" {
  source = "git::https://github.cicd.cloud.fpdev.io/CDP/terraform-module-aws-ecs"
  ecs_cluster_name = "my-cluster"
  vpc_id = "vpc-32948we2345"
  subnets = [subnet-0817346, subnet-23p48y7, subnet-197832460h]
  min_instance_size = "1"
  max_instance_size = "1"
  desired_instance_capacity = "1"
  instance_type = "t2.micro"
  key_name = "my-key
  aws_region = "us-west-2"
}
```
   
## Variables
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_id | VPC ID that the cluster will be deployed to.| string | | yes |
| ecs_cluster_name | Name for the ECS cluster that will be deployed | string | | yes | 
| subnets | Subnets that the ECS cluster and EFS mounts will be created in | list(string) | | yes |
| min_instance_size | The minimum number of ECS servers to create in the autoscaling group | number | 1 | no |
| max_instance_size | The maximuum number of ECS servers to create in the autoscaling group | number | 1 | no |
| desired_instance_capacity | The desired number of ECS servers to create in the autoscaling group | number | 1 | no |
| instance_type | The instance type to deploy to. | string | t3.medium | no |
| key_name | The key name to use for the instances. | string | "" | no |
| aws_region | AWS Region for the Terraform AWS Provider | string | us-east-2 | no |
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
