
terraform {
  backend "s3" {
    bucket         = "bimt-bucket"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "state-lock"
    encrypt        = true
  }

}

