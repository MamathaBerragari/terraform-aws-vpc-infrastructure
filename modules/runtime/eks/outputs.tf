output "cluster_id" {

  description = "EKS Cluster ID"

  value = aws_eks_cluster.this.id

}

output "cluster_name" {

  description = "EKS Cluster Name"

  value = aws_eks_cluster.this.name

}

output "cluster_arn" {

  description = "EKS Cluster ARN"

  value = aws_eks_cluster.this.arn

}

output "cluster_endpoint" {

  description = "API Server Endpoint"

  value = aws_eks_cluster.this.endpoint

}

output "cluster_security_group_id" {

  description = "Cluster Security Group"

  value = aws_security_group.cluster.id

}

output "node_security_group_id" {

  description = "Worker Node Security Group"

  value = aws_security_group.nodes.id

}

output "oidc_provider_arn" {

  description = "OIDC Provider ARN"

  value = aws_iam_openid_connect_provider.this.arn

}

output "oidc_provider_url" {

  description = "OIDC Provider URL"

  value = aws_iam_openid_connect_provider.this.url

}
