locals {

  repository_name = lower(var.repository_name)

  common_tags = merge(
    var.tags,
    {
      Name      = local.repository_name
      ManagedBy = "Terraform"
      Module    = "runtime-ecr"
    }
  )

}
