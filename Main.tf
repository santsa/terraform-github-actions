terraform {
  required_version = "~> 1.15.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  #aws s3api create-bucket --bucket santsa-terraform-actions --region eu-south-2 --create-bucket-configuration LocationConstraint=eu-south-2
  
  backend "s3" {
    bucket = "santsa-terraform-actions"
    key = "santsa-terraform-actions.tfstate"
    region = "eu-south-2"
  }
}

provider "aws" {
  region = "eu-south-2"
}

## Provider us-west-1
provider "aws" {
  alias  = "central"
  region = "us-west-1"
}
