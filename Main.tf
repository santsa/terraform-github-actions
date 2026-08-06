terraform {
  required_version = "~> 4.67.0"
  
  backend "s3" {
    bucket = "santsa-terraform-actions"
    key = "santsa-terroform-actions.tfstate"
    region = "eu-south-2"
  }
}

provider "aws" {
  region = "eu-south-2"
}
