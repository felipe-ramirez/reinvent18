# AWS re:Invent 2018 session ENT-356S

This repo contains Terraform code shown in the AWS re:Invent 2018 session **[ENT-356S: How Cox Automotive Runs GitHub Enterprise on AWS](https://www.portal.reinvent.awsevents.com/connect/search.ww#loadSearch-searchPhrase=%22ENT356-S%22&searchType=session&tc=0&sortBy=abbreviationSort&p=)** [(slide deck)](https://github.com/akinaito/reinvent18/blob/patch-1/ENT%20356-S%20How%20Cox%20Automotive%20Runs%20GitHub%20Enterprise%20on%20AWS.pdf), which demonstrates the use of a Terraform module to define the infrastructure for a GitHub Enterprise environment. The module creates a pair of instances meant for a High Availability configuration, with the first instance configured as a primary appliance using an exported configuration from an existing GitHub Enterprise appliance. You can export a configuration from an existing appliance using the ["retrieve settings" Management Console API endpoint](https://developer.github.com/enterprise/2.15/v3/enterprise-admin/management_console/#retrieve-settings).

To use this module with Terraform you would create your own `main.tf` with settings similar to the one below. You must have a valid license and settings file:

```hcl
provider "aws" {
  region = "us-west-2"
}

module "ghe" {
  source = "git::ssh://git@github.com/felipe-ramirez/reinvent18?ref=v0.1.0"

  ghe_version  = "2.15.1"
  ghe_hostname = "mygithub.example1.com"
  ghe_license  = "github-enterprise.ghl"
  ghe_settings = "settings.json"

  primary = "0"

  vpc_id      = "vpc-123b1234"
  subnet_ids  = ["subnet-546c8a45", "subnet-23c45d6e"]

  instance_type    = "r4.large"
  data_volume_size = "500"
}
```
