# Optional: These variables silence Terraform Cloud OIDC warnings
# They are set automatically by Terraform Cloud and used internally

variable "TFC_AWS_PROVIDER_AUTH" {
  description = "Terraform Cloud OIDC authentication flag (set by TFC)"
  type        = bool
  default     = true
}

variable "TFC_AWS_RUN_ROLE_ARN" {
  description = "AWS IAM role ARN for Terraform Cloud OIDC (set by TFC)"
  type        = string
  default     = ""
}

variable "TFC_AWS_RUN_REGION" {
  description = "AWS region for Terraform Cloud runs (set by TFC)"
  type        = string
  default     = "eu-west-1"
}
