	provider "aws" {
	  region = "ap-south-1"
    	}
	
	data "aws_ami" "latest_amazon_linux" {
	  most_recent = true
	  owners      = ["amazon"]
	
	  filter {
	    name   = "name"
	    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
	}
	resource "random_id" "instance_suffix" {
	  byte_length = 4
	}
	
	resource "aws_launch_template" "app" {
	  name = "app-launch-template-${random_id.instance_suffix.hex}"
	  image_id      = data.aws_ami.latest_amazon_linux.id
	  instance_type = var.instance_type
	  key_name = "aws-login-mumbai"
	
	  
	  network_interfaces {
	    associate_public_ip_address = false  # Ensure no public IPs for private subnets
	    security_groups = [data.terraform_remote_state.sg.outputs.asg_sg_id]
	  }
	
	  user_data = filebase64("${path.module}/script.sh")
	
	  tag_specifications {
	    resource_type = "instance"
	    tags = {
	      Name = "app-instance-${random_id.instance_suffix.hex}"
	    }
	  }
	      
	}
	
	resource "aws_autoscaling_group" "app" {
	  desired_capacity     =  var.desired_capacity
	  max_size             = var.max_size
	  min_size             = var.min_size
	  vpc_zone_identifier  =  data.terraform_remote_state.vpc.outputs.private_subnet_ids  #list of subnets in different AZs
	  #[var.private_subnet1_id, var.private_subnet2_id,var.private_subnets_id]
	  target_group_arns    = [data.terraform_remote_state.alb.outputs.tg_arn]
	   launch_template {
	    id      = aws_launch_template.app.id
	    version = "$Latest"
	  }
	
	  tag {
	    key                 = "Name"
	    value               =  "app-instance-${random_id.instance_suffix.hex}"
	    propagate_at_launch = true
	  }
	}
	
