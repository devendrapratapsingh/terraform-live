terraform {
  cloud {
    organization = "UniqueNotion"

    workspaces {
      name = "terraform-live"
    }
  }
  
  required_version = ">= 1.5.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# AWS Provider - Terraform Cloud handles authentication via OIDC
# Explicitly set region to match TFC_AWS_RUN_REGION
provider "aws" {
  region = "eu-west-1"  # Must match TFC_AWS_RUN_REGION variable (eu-west-1)
  # Credentials are provided automatically by Terraform Cloud via OIDC
}

# Using the official AWS S3 bucket module from public Terraform Registry
module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.2.2"

  bucket = "test-bucket-1234-${random_string.suffix.result}"
  
  # Simple configuration matching your original setup
  versioning = {
    enabled = false
  }
  
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# Generate random suffix for globally unique bucket name
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}
