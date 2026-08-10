############################################################
# ECR Repository
############################################################

resource "aws_ecr_repository" "this" {
  name                 = local.repository_name
  image_tag_mutability = var.image_tag_mutability
  force_delete         = false

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.encryption_type == "KMS" ? var.kms_key_arn : null
  }

  tags = local.common_tags
}

############################################################
# ECR Repository Policy Document
############################################################

data "aws_iam_policy_document" "repository_policy" {

  dynamic "statement" {
    for_each = length(var.repository_read_principals) > 0 ? [1] : []

    content {
      sid    = "RepositoryRead"
      effect = "Allow"

      principals {
        type        = "AWS"
        identifiers = var.repository_read_principals
      }

      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ]
    }
  }

  dynamic "statement" {
    for_each = length(var.repository_write_principals) > 0 ? [1] : []

    content {
      sid    = "RepositoryWrite"
      effect = "Allow"

      principals {
        type        = "AWS"
        identifiers = var.repository_write_principals
      }

      actions = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ]
    }
  }
}

############################################################
# ECR Repository Policy
############################################################

resource "aws_ecr_repository_policy" "this" {
  count = (
    length(var.repository_read_principals) > 0 ||
    length(var.repository_write_principals) > 0
  ) ? 1 : 0

  repository = aws_ecr_repository.this.name

  policy = data.aws_iam_policy_document.repository_policy.json
}
