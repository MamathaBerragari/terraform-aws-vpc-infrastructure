# Amazon ECR Terraform Module

## Overview

This module provisions a production-ready Amazon Elastic Container Registry (ECR).

It creates:

- Private ECR Repository
- Image Scan on Push
- Lifecycle Policy
- Repository Policy
- IAM Policy for ECR Access

---

## Features

- Private Repository
- Immutable Tags (Optional)
- Vulnerability Scanning
- Lifecycle Policy
- IAM Access Control
- Repository Policy
- KMS Encryption (using existing Foundation KMS)

---

## Resources

- aws_ecr_repository
- aws_ecr_lifecycle_policy
- aws_ecr_repository_policy
- aws_iam_policy

---

## Inputs

| Variable | Description |
|----------|-------------|
| repository_name | ECR Repository Name |
| kms_key_arn | Existing Foundation KMS Key |
| scan_on_push | Enable Image Scanning |
| image_tag_mutability | MUTABLE / IMMUTABLE |
| tags | Common Tags |

---

## Outputs

- Repository ARN
- Repository URL
- Registry ID
- IAM Policy ARN

---

## Dependencies

- Foundation IAM Module
- Foundation KMS Module

---

## Example

```hcl
module "ecr" {

  source = "../../modules/runtime/ecr"

  repository_name = "platform"

  kms_key_arn = module.kms.key_arn

  tags = local.common_tags
}
```
