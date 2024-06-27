variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of IDs for the existing public subnets"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of IDs for the existing private subnets"
  type        = list(string)
}
variable "main_route_table_id" {
  description = "The ID of the existing main route table"
  type        = string
}

variable "private_route_table_id" {
  description = "The ID of the existing private route table"
  type        = string
}
variable "private_route_exists" {
  description = "Boolean flag to check if the private route already exists"
  type        = bool
  default     = false
}

#variable "nat_gateway_id" {
 # description = "The ID of the NAT Gateway"
  #type        = string
#}
