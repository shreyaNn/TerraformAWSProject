data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "demo1-s3bucket-terraform-tfstate"
    key    = "test/vpc/terraform.tfstate"
    region = "ap-south-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "demo1-s3bucket-terraform-tfstate"
    key    = "test/sg/terraform.tfstate"
    region = "ap-south-1"
  }
}
