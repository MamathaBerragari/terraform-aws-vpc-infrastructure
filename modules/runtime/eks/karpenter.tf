module "karpenter" {

  source = "./karpenter"

  region = var.region

  cluster_name = var.cluster_name

  karpenter_version = var.karpenter_chart_version

  oidc_provider_arn = aws_iam_openid_connect_provider.this.arn

  oidc_provider_url = aws_iam_openid_connect_provider.this.url

  cluster_endpoint = aws_eks_cluster.this.endpoint

  cluster_ca_certificate = aws_eks_cluster.this.certificate_authority[0].data

}
