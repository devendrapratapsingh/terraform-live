terraform {
  cloud {
    organization = "UniqueNotion"

    workspaces {
      name = "terraform-live"
    }
  }
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
