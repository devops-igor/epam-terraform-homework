# Security group for RDS
resource "aws_security_group" "myrds-sg" {
    vpc_id = module.vpc.vpc_id
    name = "rds-sg"
  
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name: "rds-sg"
    }
}

# Subnet group for RDS
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "My DB subnet group"
  }
}

# RDS instance with PostgreSQL 14
resource "aws_db_instance" "myapp-rds" {
  identifier             = "myapp-rds"
  allocated_storage      = 5
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  db_name                = "myapp"
  username               = "myapp"
  password               = "p4$$w0rD"
  parameter_group_name   = "default.postgres14"
  skip_final_snapshot    = true
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.myrds-sg.id]
}