provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpc" {}

data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names[1] #eu-central-1b
}

output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}

output "data_aws_region_name" {
  value = data.aws_region.current.name
}

output "aws_vpcs" {
  value = data.aws_vpcs.my_vpc.ids
}




