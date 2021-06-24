# AWS ECS Module
A set of Terraform modules for working with an Elastic Container Service Cluster

## Usage
`ecs`
```hcl
module "ecs-0" {
  source                    = "AustinCloudGuru/alb/aws//modules/ecs"
  # You should pin the module to a specific version
  # version                   = "x.x.x"
  name                      = "ecs-cluster"
  image_id                  = "ami-1234567890123"
  vpc_id                    = "vpc-1234567890123"
  subnet_ids                = ["subnet-1234567890123", "subnet-2123456789012"]
  min_size                  = "1"
  max_size                  = "3"
  desired_capacity          = "2"
  instance_type             = "t3.large"
  key_name                  = "my-key"
  tags                      = {
                                Terraform = "true"
                              } 
  additional_iam_statements = var.ecs_additional_iam_statements
  attach_efs                = true
  efs_id                    = "fs-12345678"
  efs_sg_id                 = "sg-123456789012"
  depends_on_efs            = module.efs-0.mount_target_ids
}
```

`ecs-security-group`
```hcl
module "security_group_rule" {
  source            = "AustinCloudGuru/alb/aws//modules/ecs-security-group"
  # You should pin the module to a specific version
  # version           = "x.x.x"
  description       = "ecs-cluster"
  security_group_id = data.terraform_remote_state.ecs-0.outputs.security_group_id
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}
```

`ecs-service`
```hcl
module "web-server" {
  source                = "AustinCloudGuru/alb/aws//modules/ecs-service"
  # You should pin the module to a specific version
  # version               = "x.x.x"
  ecs_cluster_id        = data.terraform_remote_state.ecs.outputs.cluster_arn
  image_name            = "my-httpd:2.4.41"
  service_name          = "my-webserver"
  tld                   = "example.com"
  service_memory        = 1024
  target_group_arn      = "arn:aws:elasticloadbalancing:us-east-1:111111111111:targetgroup/my-webserver/f4fcc3a7a790a033"
  service_desired_count = 3
  port_mappings         = [
                            {
                              containerPort = 80,
                              hostPort = 80
                              protocol = "tcp"
                            }
                          ]
  deploy_with_tg        = true
}
```

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
