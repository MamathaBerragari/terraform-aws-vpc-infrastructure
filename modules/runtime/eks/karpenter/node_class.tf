resource "kubectl_manifest" "node_class" {
  yaml_body = <<YAML
apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiFamily: AL2023

  amiSelectorTerms:
    - alias: al2023@latest

  instanceProfile: ${aws_iam_instance_profile.karpenter_node.name}

  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}

  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}

  tags:
    Name: ${var.cluster_name}-karpenter-node
YAML

  depends_on = [
    aws_iam_instance_profile.karpenter_node,
    helm_release.karpenter
  ]
}
