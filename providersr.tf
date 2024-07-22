terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "github-oidc-terraform-aws-tfstates21"
    key    = "infra.tfstate"
    region = "eu-west-1"
  }
}
