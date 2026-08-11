module "karpenter" {

  count = var.enable_karpenter ? 1 : 0

  source = "./karpenter"

  region = var.region

  cluster_name = var.cluster_name

  karpenter_version = var.karpenter_chart_version

  oidc_provider_arn = aws_iam_openid_connect_provider.this.arn

  oidc_provider_url = aws_iam_openid_connect_provider.this.url

  cluster_endpoint = aws_eks_cluster.this.endpoint

  cluster_ca_certificate = aws_eks_cluster.this.certificate_authority[0].data

  tags = var.tags

  node_class_name    = var.karpenter_node_class_name
  ami_family         = var.karpenter_ami_family
  ami_selector_alias = var.karpenter_ami_selector_alias
  node_name_prefix   = var.karpenter_node_name_prefix
  discovery_tag_key  = var.karpenter_discovery_tag_key

  node_pool_name             = var.karpenter_node_pool_name
  node_pool_architecture     = var.karpenter_node_pool_architecture
  node_pool_operating_system = var.karpenter_node_pool_operating_system
  node_pool_capacity_types   = var.karpenter_node_pool_capacity_types
  consolidation_policy       = var.karpenter_consolidation_policy
  consolidate_after          = var.karpenter_consolidate_after

}
