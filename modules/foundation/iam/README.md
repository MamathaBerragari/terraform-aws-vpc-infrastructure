# IAM Foundation Module

This reusable Terraform module supports:

- IAM role creation
- Service trust relationships
- AWS principal trust relationships
- Optional OIDC provider
- OIDC web identity role assumption
- Existing managed policy attachments
- Dedicated S3 policy
- Dedicated KMS policy
- Dedicated Secrets Manager policy
- Dedicated VPC policy

The custom IAM policies are intentionally separated into:

- s3policy.tf
- kmspolicy.tf
- secretmanagerpolicy.tf
- vpcpolicy.tf

The module does not configure an AWS provider. The root environment calling
this module must configure the AWS provider.

No AWS resources are created until a root configuration calls this module and
runs terraform apply.
