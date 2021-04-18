variable "ec2_instance_type" {
  type = string
  default = "t3.micro"
}

variable "rds_instance_type" {
  type = string
  default = "db.t2.micro"
}

variable "region" {
  type = string
  default = "eu-west-2"
}

variable "availability_zone" {
  type = string
  default = "eu-west-2a"
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "db_password" {
  type = string
  default = "X9Kr8REPKhbQa5Qw"
}
