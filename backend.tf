terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "mantresh-eks-tf-state"   # your bucket
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "mantresh-eks-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}