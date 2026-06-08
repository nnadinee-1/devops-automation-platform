terraform {
  backend "s3" {
    bucket         = "nadine-devops-tfstate"
    key            = "devops-platform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "nadine-devops-tflock"
    encrypt        = true
  }
}
