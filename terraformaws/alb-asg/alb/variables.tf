#variable "vpc_id" {
 # description = "VPC ID"
  #type        = string
#}

#variable "public_subnet_ids" {
 # description = "List of public subnet IDs"
  #type        = list(string)
#}

#variable "alb_sg_id" {
 # description = "Security group ID for the ALB"
  #type        = string
#}

#variable "certificate_arn" {
 # description = "ARN of the SSL certificate"
 # type        = string
#}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

