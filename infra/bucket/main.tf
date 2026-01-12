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

# AWS Provider - Let Terraform Cloud handle authentication via OIDC
# The region comes from TFC_AWS_RUN_REGION variable
provider "aws" {
  # No explicit credentials needed - Terraform Cloud provides them via OIDC
  # Region is set via TFC_AWS_RUN_REGION workspace variable (eu-west-1)
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
