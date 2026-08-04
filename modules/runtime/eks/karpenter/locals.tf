locals {

  common_tags = merge(

    {
      ManagedBy = "Terraform"
      Module    = "Runtime-Karpenter"
    },

    var.tags

  )

}
