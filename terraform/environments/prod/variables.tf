variable "environment" {
  type        = string
  description = "The deployment environment name (e.g., prod, staging, dev)."
  default     = "production"
}

variable "azure_location" {
  type        = string
  description = "The target Azure region for core resource group deployment."
  default     = "eastus2"
}

variable "aws_region" {
  type        = string
  description = "The target AWS region for VPC and hybrid resource mapping."
  default     = "us-east-1"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the core Azure resource group."
  default     = "rg-enterprise-prod-hz"
}

variable "tags" {
  type        = map(string)
  description = "A standardized map of metadata tags for governance and FinOps tracking."
}
