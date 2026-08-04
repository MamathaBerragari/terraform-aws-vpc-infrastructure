resource "kubectl_manifest" "node_class" {
  yaml_body = <<YAML
apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2023

  role: ${aws_iam_role.karpenter_node.name}

  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}

  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}

  tags:
    Name: ${var.cluster_name}-karpenter-node
YAML

  depends_on = [helm_release.karpenter]
}
