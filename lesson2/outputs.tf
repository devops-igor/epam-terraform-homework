output "ec2_public_ip" {
    value = module.myapp-server.intance.public_ip
}

output "myrds_endpoint" {
    value = aws_db_instance.myapp-rds.endpoint
}