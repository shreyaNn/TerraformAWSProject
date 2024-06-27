#module "vpc" {
 # source = "../vpc"  # Adjust the path to your VPC module
# }

provider "aws" {
  region = var.region
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_security_group" "private_sg" {
  name_prefix = "private-sg"
  description = "Allow inbound SSH traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "private_1" {
  ami                   = data.aws_ami.amazon_linux.id
  instance_type         = var.instance_type
  subnet_id             = element(data.terraform_remote_state.vpc.outputs.private_subnet_ids, 0)  # First private subnet
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = {
    Name = "private-ec2-1"
  }
}

resource "aws_instance" "private_2" {
  ami                   = data.aws_ami.amazon_linux.id
  instance_type         = var.instance_type
  subnet_id             = element(data.terraform_remote_state.vpc.outputs.private_subnet_ids, 1)  # Second private subnet
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = {
    Name = "private-ec2-2"
  }
}

