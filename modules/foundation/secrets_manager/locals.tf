locals {
  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "SecretsManager"
    },
    var.tags
  )

  create_resource_policy = (
    length(var.allowed_principal_arns) > 0 ||
    var.additional_policy_json != null
  )
}
