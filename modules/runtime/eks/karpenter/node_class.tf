resource "kubectl_manifest" "node_class" {
  yaml_body = <<YAML
apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: ${var.node_class_name}
spec:
  amiFamily: ${var.ami_family}

  amiSelectorTerms:
    - alias: ${var.ami_selector_alias}

  instanceProfile: ${aws_iam_instance_profile.karpenter_node.name}

  subnetSelectorTerms:
    - tags:
        ${var.discovery_tag_key}: ${var.cluster_name}

  securityGroupSelectorTerms:
    - tags:
        ${var.discovery_tag_key}: ${var.cluster_name}

  tags:
    Name: ${var.node_name_prefix}-${var.cluster_name}
YAML

  depends_on = [
    aws_iam_instance_profile.karpenter_node,
    helm_release.karpenter
  ]
}
