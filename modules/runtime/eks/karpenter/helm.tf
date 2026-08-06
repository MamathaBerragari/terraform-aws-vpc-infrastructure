resource "helm_release" "karpenter" {
  name             = "karpenter"
  namespace        = "karpenter"
  create_namespace = true

  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = var.karpenter_version

  set = [
    {
      name  = "settings.clusterName"
      value = var.cluster_name
    },

    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.karpenter_controller.arn
    }
  ]

  depends_on = [
    aws_iam_role.karpenter_controller,
    aws_sqs_queue.interruption_queue,
  ]
}
