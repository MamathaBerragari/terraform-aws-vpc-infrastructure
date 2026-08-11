############################################################
# EKS Cluster IAM Assume Role Policy
############################################################

data "aws_iam_policy_document" "eks_assume_role" {
  statement {
    actions = var.cluster_assume_role_actions

    principals {
      type        = var.cluster_assume_role_principal_type
      identifiers = var.cluster_assume_role_principal_identifiers
    }
  }
}

############################################################
# EKS Node IAM Assume Role Policy
############################################################

data "aws_iam_policy_document" "node_assume_role" {
  statement {
    actions = var.node_assume_role_actions

    principals {
      type        = var.node_assume_role_principal_type
      identifiers = var.node_assume_role_principal_identifiers
    }
  }
}

############################################################
# EKS Cluster IAM Role
############################################################

resource "aws_iam_role" "cluster" {
  name               = "${var.cluster_name}-${var.cluster_role_name_suffix}"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.cluster_name}-${var.cluster_role_name_suffix}"
    }
  )
}

############################################################
# EKS Cluster IAM Policy
############################################################

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  role       = aws_iam_role.cluster.name
  policy_arn = var.cluster_policy_arn
}

############################################################
# EKS Worker Node IAM Role
############################################################

resource "aws_iam_role" "node" {
  name               = "${var.cluster_name}-${var.node_role_name_suffix}"
  assume_role_policy = data.aws_iam_policy_document.node_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.cluster_name}-${var.node_role_name_suffix}"
    }
  )
}

############################################################
# Worker Node IAM Policy Attachments
############################################################

resource "aws_iam_role_policy_attachment" "worker_node" {
  role       = aws_iam_role.node.name
  policy_arn = var.worker_node_policy_arn
}

resource "aws_iam_role_policy_attachment" "cni" {
  role       = aws_iam_role.node.name
  policy_arn = var.cni_policy_arn
}

resource "aws_iam_role_policy_attachment" "ecr_read" {
  role       = aws_iam_role.node.name
  policy_arn = var.ecr_read_policy_arn
}
