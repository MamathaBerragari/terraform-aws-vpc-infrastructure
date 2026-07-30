# KMS Foundation Module

This reusable Terraform module creates:

- Customer-managed KMS key
- KMS alias
- Root account recovery permissions
- Optional key administrators
- Optional key users
- Optional AWS service grant permissions
- Optional custom KMS policy
- Optional multi-Region key
- Automatic rotation for supported symmetric keys

The module is not connected to test or production yet.
