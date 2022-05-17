provider "aws" {
    region = "eu-north-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_avail_zones
  private_subnets = var.private_subnets_cidr_blocks
  public_subnets  = [var.public_subnet_cidr_block]
  public_subnet_tags = { Name =  "${var.env_prefix}-subnet-1" }

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}
# Provide EC2 instance with local module webserver
module "myapp-server" {
    source = "./modules/webserver"
    vpc_id = module.vpc.vpc_id
    my_ip = var.my_ip 
    env_prefix = var.env_prefix
    image_name = var.image_name
    public_key_location = var.public_key_location
    instance_type = var.instance_type
    subnet_id = module.vpc.public_subnets[0]
    avail_zone = var.avail_zone
}
