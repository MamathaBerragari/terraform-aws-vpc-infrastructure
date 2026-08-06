data "aws_iam_policy_document" "eks_assume_role" {

  statement {

    actions = ["sts:AssumeRole"]

    principals {

      type = "Service"

      identifiers = [
        "eks.amazonaws.com"
      ]

    }

  }

}

data "aws_iam_policy_document" "node_assume_role" {

  statement {

    actions = ["sts:AssumeRole"]

    principals {

      type = "Service"

      identifiers = [
        "ec2.amazonaws.com"
      ]

    }

  }

}

###############################################################
# EKS Cluster IAM Role
###############################################################

resource "aws_iam_role" "cluster" {

  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.cluster_name}-cluster-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {

  role = aws_iam_role.cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}

resource "aws_iam_role" "node" {

  name = "${var.cluster_name}-node-role"

  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.cluster_name}-node-role"
    }
  )
}

###############################################################
# Worker Node Policy Attachments
###############################################################

resource "aws_iam_role_policy_attachment" "worker_node" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}

resource "aws_iam_role_policy_attachment" "cni" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}

resource "aws_iam_role_policy_attachment" "ecr_read" {

  role = aws_iam_role.node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}
