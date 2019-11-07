# AWS ECS Terraform Module
Terraform module that deploys an ECS autoscaling group with EFS as a datastore.

## Usage
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

