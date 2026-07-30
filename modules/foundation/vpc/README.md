# VPC Foundation Module

This reusable Terraform module creates:

- Amazon VPC
- Public and private subnets
- Internet Gateway
- Elastic IP addresses
- NAT Gateways
- Public and private route tables
- Route table associations
- Optional Gateway VPC endpoints
- Optional Interface VPC endpoints

No VPC endpoints are created by default because the vpc_endpoints variable
defaults to an empty map.

The AWS provider configuration is inherited from the root module.
