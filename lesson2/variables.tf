variable vpc_cidr_block {
    default = "10.0.0.0/16"
}
variable public_subnet_cidr_block {
    default = "10.0.10.0/24"
}
variable "private_subnets_cidr_blocks" {
    default = ["10.0.20.0/24", "10.0.30.0/24"]
}
variable avail_zone {
    description = "EC2 instance availability zone"
    default = "eu-north-1a"
}
variable vpc_avail_zones {
    description = "VPC availability zones"
    default = ["eu-north-1a", "eu-north-1b"]
}
variable env_prefix {
    default = "dev"
}
variable instance_type {
    default = "t3.micro"
}
variable public_key_location {
    default = "myapp_server.pub"
    description = "Location of pub part of SSH key-pair"
}
variable image_name {
    default = "amzn2-ami-hvm-*-x86_64-gp2"
    description = "Name of AMI in AWS catalog"
}
variable my_ip {
    default = "0.0.0.0/0"
    description = "Allows SSH connection from specific IP"
}