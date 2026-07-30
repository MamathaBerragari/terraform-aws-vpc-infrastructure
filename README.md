# Terraform AWS VPC Infrastructure

This repository provides:

- Terraform bootstrap infrastructure
- S3 remote-state storage
- AWS KMS encryption
- DynamoDB table
- Reusable VPC module
- Separate test and production environments
- Public and private subnets
- Internet gateways
- NAT gateways
- Route tables and associations

## Deployment order

1. Bootstrap
2. Test
3. Production
