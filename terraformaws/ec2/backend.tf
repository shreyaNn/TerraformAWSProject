terraform {
  backend "s3" {
    bucket         = "demo1-s3bucket-terraform-tfstate"
    key            = "test/ec2/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}



