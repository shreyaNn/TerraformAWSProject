provider "aws" {
  region = var.region
}
resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.sg.outputs.alb_sg_id]
  subnets            = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  tags = {
    Name = "my-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "my-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

#resource "aws_lb_listener" "https_listener" {
#  load_balancer_arn = aws_lb.alb.arn
 # port              = "443"
  #protocol          = "HTTPS"

  #default_action {
   # type             = "forward"
    #target_group_arn = aws_lb_target_group.tg.arn
  #}

  #ssl_policy = "ELBSecurityPolicy-2016-08"

  #certificate_arn = var.certificate_arn
#}
