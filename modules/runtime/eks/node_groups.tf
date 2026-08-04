resource "aws_eks_node_group" "default" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${var.cluster_name}-default"

  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  capacity_type = "ON_DEMAND"

  ami_type = "AL2023_x86_64_STANDARD"

  instance_types = [
    "t3.medium"
  ]

  scaling_config {

    desired_size = 2
    min_size     = 2
    max_size     = 5

  }

  launch_template {

    id      = aws_launch_template.nodes.id
    version = "$Latest"

  }

  update_config {

    max_unavailable = 1

  }

  tags = local.common_tags

}
