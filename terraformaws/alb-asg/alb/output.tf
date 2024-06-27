output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value = aws_lb.alb.dns_name
}

output "tg_arn" {
  description = "The ARN of the target group"
  value = aws_lb_target_group.tg.arn
}
