resource "kubectl_manifest" "node_pool" {
  yaml_body = <<YAML
apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: default
spec:

  template:
    spec:

      nodeClassRef:
        group: karpenter.k8s.aws
        kind: EC2NodeClass
        name: default

      requirements:

      - key: kubernetes.io/arch
        operator: In
        values:
          - amd64

      - key: kubernetes.io/os
        operator: In
        values:
          - linux

      - key: karpenter.sh/capacity-type
        operator: In
        values:
          - on-demand
          - spot

  disruption:

    consolidationPolicy: WhenEmpty

    consolidateAfter: 30s
YAML

  depends_on = [
    kubectl_manifest.node_class
  ]
}
