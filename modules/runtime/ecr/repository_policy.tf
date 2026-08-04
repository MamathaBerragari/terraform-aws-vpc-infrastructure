data "aws_iam_policy_document" "repository_policy" {

  dynamic "statement" {

    for_each = length(var.repository_read_principals) > 0 ? [1] : []

    content {

      sid = "RepositoryRead"

      effect = "Allow"

      principals {

        type = "AWS"

        identifiers = var.repository_read_principals

      }

      actions = [

        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"

      ]

    }

  }

  dynamic "statement" {

    for_each = length(var.repository_write_principals) > 0 ? [1] : []

    content {

      sid = "RepositoryWrite"

      effect = "Allow"

      principals {

        type = "AWS"

        identifiers = var.repository_write_principals

      }

      actions = [

        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"

      ]

    }

  }

}

resource "aws_ecr_repository_policy" "this" {

  repository = aws_ecr_repository.this.name

  policy = data.aws_iam_policy_document.repository_policy.json

}
