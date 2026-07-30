# Secrets Manager Foundation Module

This reusable Terraform module creates:

- Secrets Manager secret metadata
- Optional customer-managed KMS encryption
- Optional secret resource policy
- Optional Lambda-based automatic rotation

This module intentionally does not create an
aws_secretsmanager_secret_version resource.

Secret values should not be hardcoded in Terraform configuration because they
may be stored in Terraform state.

The module is not connected to test or production yet.
