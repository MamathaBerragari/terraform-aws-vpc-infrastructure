locals {
  common_tags = merge(
    {
      ManagedBy = var.managed_by
      Module    = var.module_name
    },
    var.tags
  )
}
