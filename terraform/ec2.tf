resource "aws_instance" "tf_ec2_instance" {
  ami               = var.ami
  instance_type     = var.ec2_instance_type
  key_name          = var.key_name
  availability_zone = var.availability_zone
  vpc_security_group_ids = [aws_security_group.tf_ec2_sg.id]

  root_block_device {
    volume_type   = "gp2"
    volume_size   = "8"
  }

  tags = {
    Name = "TF EC2 Instance"
  }
}

resource "aws_security_group" "tf_ec2_sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TF EC2 Security Group"
  }
}

output "tf_ec2_instance_ip" {
  value = aws_instance.tf_ec2_instance.public_ip
}
