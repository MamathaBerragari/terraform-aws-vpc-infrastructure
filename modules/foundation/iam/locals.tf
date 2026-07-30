locals {
  role_name = var.role_name != null ? var.role_name : "${var.name_prefix}-role"

  oidc_provider_host = trimprefix(
    coalesce(var.oidc_provider_url, "https://invalid.example.com"),
    "https://"
  )

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "IAM"
    },
    var.tags
  )

  custom_policy_arns = concat(
    var.create_s3_policy ? [aws_iam_policy.s3[0].arn] : [],
    var.create_kms_policy ? [aws_iam_policy.kms[0].arn] : [],
    var.create_secrets_manager_policy ? [aws_iam_policy.secrets_manager[0].arn] : [],
    var.create_vpc_policy ? [aws_iam_policy.vpc[0].arn] : []
  )

  attachment_arns = toset(
    concat(
      tolist(var.managed_policy_arns),
      local.custom_policy_arns
    )
  )
}
