locals {
  repository_name = lower(trimspace(var.repository_name))

  common_tags = merge(
    var.tags,
    {
      Name      = local.repository_name
      ManagedBy = var.managed_by
      Module    = var.module_name
    }
  )
}
