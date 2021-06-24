package test

import (
	"testing"
	"fmt"
	"time"
    http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/aws"
	//"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestExamplesTerraform(t *testing.T) {
  t.Parallel()
  terraformOpts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
    TerraformDir: "../examples/terratest/",
  })

  defer terraform.Destroy(t, terraformOpts)
  terraform.InitAndApply(t, terraformOpts)

  ecsArn := terraform.Output(t, terraformOpts, "cluster_arn")
  assert.Contains(t, ecsArn, "terratest-cluster")

  asg := aws.GetInstanceIdsForAsg(t, "terratest-cluster", "us-west-2")
  instance_ip := aws.GetPublicIpOfEc2Instance(t, asg[0], "us-west-2")
  
  url := fmt.Sprintf("http://%s", instance_ip)
  http_helper.HttpGetWithRetry(t, url, nil, 200, "<html><body><h1>It works!</h1></body></html>", 10, 10*time.Second)


}
