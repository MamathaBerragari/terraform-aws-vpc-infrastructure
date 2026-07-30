data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    for_each = length(var.trusted_service_principals) > 0 ? [1] : []

    content {
      sid     = "AllowServiceAssumeRole"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "Service"
        identifiers = var.trusted_service_principals
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.trusted_aws_principal_arns) > 0 ? [1] : []

    content {
      sid     = "AllowAWSPrincipalAssumeRole"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = var.trusted_aws_principal_arns
      }
    }
  }

  dynamic "statement" {
    for_each = var.create_oidc_provider ? [1] : []

    content {
      sid     = "AllowOIDCAssumeRole"
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [aws_iam_openid_connect_provider.this[0].arn]
      }

      dynamic "condition" {
        for_each = length(var.oidc_subjects) > 0 ? [1] : []

        content {
          test     = "StringLike"
          variable = "${local.oidc_provider_host}:sub"
          values   = var.oidc_subjects
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_audiences) > 0 ? [1] : []

        content {
          test     = "StringEquals"
          variable = "${local.oidc_provider_host}:aud"
          values   = var.oidc_audiences
        }
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                 = local.role_name
  description          = var.role_description
  path                 = var.role_path
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary_arn

  tags = merge(
    local.common_tags,
    {
      Name = local.role_name
    }
  )

  lifecycle {
    precondition {
      condition = (
        length(var.trusted_service_principals) > 0 ||
        length(var.trusted_aws_principal_arns) > 0 ||
        var.create_oidc_provider
      )
      error_message = "Configure at least one service, AWS principal or OIDC provider."
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.create_role ? local.attachment_arns : toset([])

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}
