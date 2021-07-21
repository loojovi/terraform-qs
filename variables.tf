variable "aws_profile" {
  default = "default"
  description = "aws profile name in machine running terraform"
}

variable "aws_region" {
  default = "ap-southeast-1"
  description = "aws region"
}

variable "user_cidr" {
  default = "27.125.181.162/32"
  description = "user cidr range"
}

variable "service" {
  default = "jupyter"
  description = "name of service"
}

variable "instance_type" {
  default = "t2.micro"
  description = "ec2 instance type for jupyter service"
}

variable "user_name" {
  default = "qs-jovi" # TOD: Change this so that resources created will be unique
}