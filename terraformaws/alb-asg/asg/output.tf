output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value = aws_autoscaling_group.app.name
}
output "asg_security_group_id" {
  description = "The security group ID associated with the ASG"
  value       = data.terraform_remote_state.sg.outputs.asg_sg_id
}
#output "launch_template_id" {
 # description = "The ID of the Launch Template"
  #value       = aws_launch_template.app.id
#}

#output "instance_ids" {
  #description = "The IDs of the instances in the Auto Scaling Group"
 # value       = aws_autoscaling_group.app.instances
#}

#output "instance_security_group_id" {
 # description = "The security group ID associated with the instances"
  #value       = var.ec2_sg_id
#}
#output "alb_security_group_id" {
 # description = "The security group ID associated with the ALB"
 # value       = var.alb_sg_id
#}
