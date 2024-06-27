provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_internet_gateway" "igw" {
  filter {
    name   = "attachment.vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "public" {
  for_each = toset(var.public_subnet_ids)
  id       = each.key
}

data "aws_subnet" "private" {
  for_each = toset(var.private_subnet_ids)
  id       = each.key
}

data "aws_route_table" "main" {
   filter {
    name   = "route-table-id"
    values = [var.main_route_table_id]
  }
}

data "aws_route_table" "private" {
     filter {
    name   = "route-table-id"
    values = [var.private_route_table_id]
  }
}


resource "aws_ec2_tag" "main_route_table_tag" {
  resource_id = data.aws_route_table.main.id
  key         = "Name"
  value       = "main-public-rt"
}


resource "aws_route_table_association" "public_subnet_assoc" {
  for_each      = toset(var.public_subnet_ids)
  subnet_id     = each.key
  route_table_id = data.aws_route_table.main.id
}

resource "aws_route_table_association" "private_subnet_assoc" {
  for_each      = toset(var.private_subnet_ids)
  subnet_id     = each.key
  route_table_id = data.aws_route_table.private.id
}
data "aws_route" "existing_private_route" {
  route_table_id         = var.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
   depends_on             = [aws_nat_gateway.main]
  count                  = 0
}


resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(var.public_subnet_ids, 0)
  tags = {
    Name = "main-nat-gateway"
  }
}
resource "null_resource" "create_private_route" {
  provisioner "local-exec" {
    command = <<EOT
      aws ec2 describe-route-tables --route-table-ids ${var.private_route_table_id} --query 'RouteTables[0].Routes[?DestinationCidrBlock==`0.0.0.0/0`]' | grep -q nat- || aws ec2 create-route --route-table-id ${var.private_route_table_id} --destination-cidr-block 0.0.0.0/0 --nat-gateway-id ${aws_nat_gateway.main.id}
    EOT
  }
}


 #Ensure the NAT Gateway connects to the existing private route table
resource "aws_route" "private_route" {
  count = length(data.aws_route.existing_private_route) == 0 ? 1 : 0

  route_table_id         = var.private_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}
