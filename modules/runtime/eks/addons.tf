###############################################################
# EKS Managed Add-ons
###############################################################

resource "aws_eks_addon" "this" {
  for_each = var.eks_addons

  cluster_name = aws_eks_cluster.this.name

  addon_name = each.value.addon_name

  addon_version = each.value.addon_version

  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create

  service_account_role_arn = (
    each.value.service_account_role_type == "ebs_csi"
    ? aws_iam_role.ebs_csi.arn
    : null
  )

  tags = local.common_tags

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi
  ]
}

moved {
  from = aws_eks_addon.coredns
  to   = aws_eks_addon.this["coredns"]
}

moved {
  from = aws_eks_addon.ebs_csi
  to   = aws_eks_addon.this["ebs_csi"]
}

moved {
  from = aws_eks_addon.kube_proxy
  to   = aws_eks_addon.this["kube_proxy"]
}

moved {
  from = aws_eks_addon.vpc_cni
  to   = aws_eks_addon.this["vpc_cni"]
}
