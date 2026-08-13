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
  each.key == "ebs_csi"
  ? aws_iam_role.ebs_csi.arn
  : null
)

  tags = local.common_tags
}
