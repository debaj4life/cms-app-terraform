terraform {
  required_version = "~>1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  backend "s3" {
    bucket = "techrite-cms-bck"
    region = "eu-west-2"
    key    = "techrite/dev/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      BillingID = "Platform"
      Project   = "CMS-Application"
      Terraform = true
    }
  }
}