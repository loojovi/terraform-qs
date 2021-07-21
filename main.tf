provider "aws" {
  region    = var.aws_region
  profile   = var.aws_profile
}

terraform {
  backend "local" {
  }
}

data "aws_ami" "al2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "key-${uuid()}"
  public_key = "${tls_private_key.key.public_key_openssh}"
}

resource "local_file" "pem" {
  filename        = "${aws_key_pair.generated_key.key_name}.pem"
  content         = "${tls_private_key.key.private_key_pem}"
  file_permission = "400"
}

resource "aws_security_group" "jupyter" {
    name = "${var.service}-${var.user_name}"
    description = "security group for ${title(var.service)}"

  ingress {
    description      = "Access Jupyter Notebook"
    from_port        = 8888
    to_port          = 8898
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jupyter" {
  ami = "${data.aws_ami.al2.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.generated_key.key_name}"
  security_groups = [aws_security_group.jupyter.name]
  user_data = "${file("script.sh")}"
  tags = {
       Name = "${var.user_name}"
   }
}

