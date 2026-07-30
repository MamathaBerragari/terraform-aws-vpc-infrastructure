# S3 Foundation Module

This reusable Terraform module creates:

- S3 bucket
- Bucket ownership controls
- Public access block
- Versioning
- SSE-S3 encryption when no KMS key is provided
- SSE-KMS encryption when a KMS key is provided
- Optional S3 Bucket Key
- TLS-only bucket policy
- Optional principal-based bucket access
- Optional additional bucket policy
- Optional lifecycle rules

The module is not connected to test or production yet.
