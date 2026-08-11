resource "kubectl_manifest" "node_pool" {
  yaml_body = <<YAML
apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: ${var.node_pool_name}
spec:
  template:
    spec:
      nodeClassRef:
        group: karpenter.k8s.aws
        kind: EC2NodeClass
        name: ${var.node_class_name}

      requirements:
        - key: kubernetes.io/arch
          operator: In
          values:
            - ${var.node_pool_architecture}

        - key: kubernetes.io/os
          operator: In
          values:
            - ${var.node_pool_operating_system}

        - key: karpenter.sh/capacity-type
          operator: In
          values:
%{for capacity_type in var.node_pool_capacity_types~}
            - ${capacity_type}
%{endfor~}

  disruption:
    consolidationPolicy: ${var.consolidation_policy}
    consolidateAfter: ${var.consolidate_after}
YAML

  depends_on = [
    kubectl_manifest.node_class
  ]
}
