locals {
  name_prefix = "${var.environment}-vpc"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "VPC"
  }

  az_names = var.availability_zones

  public_subnets = {
    for idx, cidr in var.public_subnet_cidrs : cidr => {
      cidr = cidr
      az   = local.az_names[idx % length(local.az_names)]
      idx  = idx + 1
    }
  }

  private_subnets = {
    for idx, cidr in var.private_subnet_cidrs : cidr => {
      cidr = cidr
      az   = local.az_names[idx % length(local.az_names)]
      idx  = idx + 1
    }
  }
}
