locals {

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "Runtime-EKS"
    },
    var.tags
  )

}
