resource "aws_eks_node_group" "default" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${var.cluster_name}-default"

  node_role_arn = aws_iam_role.node.arn

  subnet_ids = var.private_subnet_ids

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  instance_types = [
    "t3.medium"
  ]

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  launch_template {

    id      = aws_launch_template.nodes.id
    version = aws_launch_template.nodes.latest_version

  }

  update_config {

    max_unavailable = 1

  }

  tags = local.common_tags

}
