#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
}

#------------------------------------------------------------------------------
# Get the latest ECS AMI
#------------------------------------------------------------------------------
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

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "terratest-vpc"
  cidr               = "10.0.0.0/16"
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "mark"
    Environment = "terratest"
  }
}

module "ecs" {
  source           = "../../modules/ecs"
  name             = "terratest-cluster"
  image_id         = data.aws_ami.latest_ecs_ami.image_id
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnets
  min_size         = "1"
  max_size         = "1"
  desired_capacity = "1"
  instance_type    = "t3.large"
  key_name         = "aws-main"
  tags = {
    Terraform = "true"
  }
}

module "security_group_rule" {
  source            = "../../modules/ecs-security-group"
  description       = "ecs-cluster"
  security_group_id = module.ecs.security_group_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

module "ecs-service" {
  source                = "../../modules/ecs-service"
  ecs_cluster_id        = module.ecs.cluster_arn
  image_name            = "my-httpd:2.4.41"
  service_name          = "terratest-webserver"
  service_memory        = 1024
  service_desired_count = 1
  port_mappings = [
    {
      containerPort = 80,
      hostPort      = 80
      protocol      = "tcp"
    }
  ]
}
