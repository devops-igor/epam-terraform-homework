provider "aws" {
  region = "eu-north-1"
}

data "aws_vpcs" "vpcs" {
}

data "aws_vpc" "vpc" {
  count = length(data.aws_vpcs.vpcs.ids)
  id    = tolist(data.aws_vpcs.vpcs.ids)[count.index]
}

data "aws_subnets" "subnets" {
  count = length(data.aws_vpcs.vpcs.ids)
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc[count.index].id]
  }
}

data "aws_security_groups" "sgs" {
  count = length(data.aws_vpcs.vpcs.ids)
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc[count.index].id]
  }
}

output "vpc" {
    description = "VPCs ids"
    value = data.aws_vpcs.vpcs.ids
}

output "subnets" {
    description = "Subnets in VPC"
    value = data.aws_subnets.subnets
}

output "sgs" {
    description = "Security groups in VPC"
    value = data.aws_security_groups.sgs
}