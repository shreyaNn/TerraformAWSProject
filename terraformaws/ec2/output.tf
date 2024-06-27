output "instance_1_id" {
  description = "The ID of the first EC2 instance"
  value       = aws_instance.private_1.id
}

output "instance_2_id" {
  description = "The ID of the second EC2 instance"
  value       = aws_instance.private_2  .id
}
