resource "aws_db_instance" "tf_rds" {
  allocated_storage = 20
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.20"
  instance_class    = var.rds_instance_type
  name              = "tf_rds"
  username          = var.db_username
  password          = var.db_password
  skip_final_snapshot = true
  availability_zone = var.availability_zone
  vpc_security_group_ids = [aws_security_group.tf_rds_sg.id]

  tags = {
    Name = "TF RDS Instance"
  }
}

resource "aws_security_group" "tf_rds_sg" {
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.tf_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF RDS Security Group"
  }
}

output "tf_rds_endpoint" {
  value = aws_db_instance.tf_rds.endpoint
}

output "tf_rds_password" {
  value = aws_db_instance.tf_rds.password
  sensitive = true
}

output "tf_rds_username" {
  value = aws_db_instance.tf_rds.username
  sensitive = true
}
