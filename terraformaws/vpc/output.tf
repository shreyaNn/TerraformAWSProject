output "vpc_id" {
  value       = data.aws_vpc.main.id
  description = "The ID of the existing VPC"
}

output "public_subnet_ids" {
  value       = [for s in data.aws_subnet.public : s.id]
  description = "IDs of the existing public subnets"
}

output "private_subnet_ids" {
 value       = [for s in data.aws_subnet.private : s.id]
  description = "IDs of the existing private subnets"
}

output "internet_gateway_id" {
  value       = data.aws_internet_gateway.igw.id
  description = "ID of the Internet Gateway associated with the VPC"
}

output "main_route_table_id" {
  value       = data.aws_route_table.main.id
  description = "ID of the main route table associated with the VPC"
}

output "private_route_table_id" {
  value       = data.aws_route_table.private.id
  description = "ID of the route table for private subnets"
}
output "nat_gateway_id" {
  value       = aws_nat_gateway.main.id
  description = "ID of the NAT Gateway"
}
output "public_subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.public : s.cidr_block]
}

output "private_subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.private : s.cidr_block]
} 
output "vpc_cidr_block" {
  value = data.aws_vpc.main.cidr_block
}