# AWS ECS Terraform Module
Terraform module that deploys an ECS autoscaling group.  If you include an EFS ID and EFS Security Group, it will also mount the EFS volume to the ECS instances.  

# Deploying with EFS
By default, the module will deploy without trying to mount an EFS volume.  If you attempt to deploy the EFS at the same time as the ECS cluster, a race condition exists where the autoscaling group gets created before the mount targets have finished being created.   To avoid this, you can set the depends_on_efs variable to the aws_efs_mount_target output.  This way, the autoscaling group won't get created until the EFS mount targets have been created.

## Usage
```hcl-terraform
module "ecs-0" {
  source                        = "AustinCloudGuru/ecs/aws"
  version                       = "1.1.0"
  name                          = "my-ecs-cluster"
  vpc_id                        = vpc-0e151a59f874eadd8
  cidr_block                    = ["10.0.0.0/8"]
  subnet_ids                    = ["subnet-1e151a59f874eadd8", "subnet-0e148a59f874eadd8", "subnet-2e151a57f874eadd8"]
  min_size                      = "1"
  max_size                      = "3"
  desired_capacity              = "2"
  instance_type                 = "t2.large"
  key_name                      = "aws-key"
  image_id                      = "ami-2f56774e"
  tags                          = var.tags
  additional_iam_statements     = var.additional_iam_statements
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

additional_iam_statements = [
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
| image_id | The EC2 image ID to launch | string | ""t3.medium"" | yes |
| attach_efs | Whether to try and attach an EFS volume to the instances | bool | false | no
| efs_sg_id | The EFS Security Group ID  - Required if attach_efs is true | string | "" | no |
| efs_id | The EFS ID  - Required if attach_efs is true | String | "" | no |
| depends_on_efs | If attaching EFS, it makes sure that the mount targets are ready | list(string) | [] | no |
| name | Name for the ECS cluster that will be deployed | string | | yes | 
| cidr_block | Cider Block for the Security Group | list(string) | | yes |
| min_size | The minimum number of ECS servers to create in the autoscaling group | number | 1 | no |
| max_size | The maximuum number of ECS servers to create in the autoscaling group | number | 1 | no |
| desired_capacity | The desired number of ECS servers to create in the autoscaling group | number | 1 | no |
| instance_type | The instance type to deploy to. | string | t3.medium | no |
| key_name | The key name to use for the instances. | string | "" | no |
| associate_public_ip_address | Whether to associate a public IP in the launch configuration | bool | false | no | 
| additional_iam_statements | Additional IAM statements for the ECS instances | list(object) | [] | no |
| tags | A map of tags to add to all resources | map(string) | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ECS cluster ID |
| cluster_arn | The ECS cluster ARN |

## Getting the AMI Version
You can get the latest version of the AMI by running the following command.
```hcl-terraform
data "aws_ami" "latest_ecs_ami" {
  most_recent = true
  owners      = ["591542846629"] # AWS
  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```
If you are in both regular AWS and GovCloud, you can find the latest in either by creating a variable called govcloud and setting it to true or false and adding the following code:

```hcl-terraform
locals {
  latest_ami   = var.govcloud ? "580842271618" : "591542846629"
}

#------------------------------------------------------------------------------
# Get the latest ECS AMI
#------------------------------------------------------------------------------
data "aws_ami" "latest_ecs_ami" {
  most_recent = true
  owners      = [local.latest_ami] # AWS
  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
