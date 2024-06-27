#variable "image_id" {
 # description = "The AMI ID to use for the instance"
  #type        = string
#}
variable "instance_type" {
  description = "The instance type for the ASG"
  type = string
}


variable "desired_capacity" {
  description = "Desired number of instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
}
