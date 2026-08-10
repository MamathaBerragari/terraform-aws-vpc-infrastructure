locals {
  name_prefix = "${var.project_name}-${var.environment}-vpc"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "foundation-vpc"
    }
  )

  az_names = var.availability_zones

  # Use Availability Zone as the Terraform resource key.
  # This preserves existing resources such as:
  # aws_subnet.public["ap-south-1a"]
  # aws_subnet.public["ap-south-1b"]
  public_subnets = {
    for idx, cidr in var.public_subnet_cidrs :
    local.az_names[idx] => {
      cidr  = cidr
      az    = local.az_names[idx]
      index = idx + 1
    }
  }

  private_subnets = {
    for idx, cidr in var.private_subnet_cidrs :
    local.az_names[idx] => {
      cidr  = cidr
      az    = local.az_names[idx]
      index = idx + 1
    }
  }

  first_public_subnet_key = sort(keys(local.public_subnets))[0]

  nat_gateway_subnets = var.single_nat_gateway ? {
    one = {
      public_subnet_key = local.first_public_subnet_key
      az                = local.public_subnets[local.first_public_subnet_key].az
      index             = 1
    }
    } : {
    for az in local.az_names :
    az => {
      public_subnet_key = az
      az                = az
      index             = index(local.az_names, az) + 1
    }
  }
}
