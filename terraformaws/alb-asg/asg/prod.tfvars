image_id           = "ami-09859101d317198f9 " 
instance_type      = "t2.micro"  # Replace with your desired instance type
#ec2_sg_id          = "sg-0de70be43fa43827a"  # Replace with your EC2 security group ID
alb_sg_id  = "sg-069be7c5d466b9c46"
asg_sg_id  = "sg-0de70be43fa43827a"
private_subnets_ids = ["subnet-06fae6b5759d6c0c6", "subnet-0e4cbbc58d5d04c08"]
target_group_arn   = "arn:aws:elasticloadbalancing:ap-south-1:590183854976:targetgroup/my-tg/20d84da62de6fa31"  # Replace with your target group ARN
vpc_id = "vpc-07420e1a033c8b123"
desired_capacity = 2
max_size = 2
min_size = 2


