output "role_name" {
  description = "IAM role name."
  value       = try(aws_iam_role.this[0].name, null)
}

output "role_arn" {
  description = "IAM role ARN."
  value       = try(aws_iam_role.this[0].arn, null)
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN."
  value       = try(aws_iam_openid_connect_provider.this[0].arn, null)
}

output "oidc_provider_url" {
  description = "OIDC provider URL."
  value       = try(aws_iam_openid_connect_provider.this[0].url, null)
}

output "policy_arns" {
  description = "ARNs of the separately created IAM policies."

  value = {
    s3              = try(aws_iam_policy.s3[0].arn, null)
    kms             = try(aws_iam_policy.kms[0].arn, null)
    secrets_manager = try(aws_iam_policy.secrets_manager[0].arn, null)
    vpc             = try(aws_iam_policy.vpc[0].arn, null)
  }
}
