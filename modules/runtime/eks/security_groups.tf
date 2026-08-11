############################################################
# EKS Cluster Security Group
############################################################

resource "aws_security_group" "cluster" {

  name        = "${var.cluster_name}-cluster-sg"
  description = "Security Group for EKS Cluster"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.cluster_name}-cluster-sg"
    }
  )
}

############################################################
# Cluster Egress
############################################################

resource "aws_security_group_rule" "cluster_egress" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = ["0.0.0.0/0"]
}

############################################################
# EKS Worker Node Security Group
############################################################

resource "aws_security_group" "nodes" {

  name        = "${var.cluster_name}-nodes-sg"
  description = "Worker Node Security Group"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name                     = "${var.cluster_name}-nodes-sg"
      "karpenter.sh/discovery" = var.cluster_name
    }
  )
}

############################################################
# Worker Nodes → EKS Control Plane
############################################################

resource "aws_security_group_rule" "nodes_to_cluster" {

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.nodes.id
}

############################################################
# EKS Control Plane → Worker Nodes
############################################################

resource "aws_security_group_rule" "cluster_to_nodes" {

  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.cluster.id

  description = "Allow EKS control plane to communicate with kubelet"
}

############################################################
# Worker Nodes → Worker Nodes
############################################################

resource "aws_security_group_rule" "nodes_to_nodes" {

  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes.id
  source_security_group_id = aws_security_group.nodes.id

  description = "Allow worker nodes to communicate with each other"
}

############################################################
# Worker Node Egress
############################################################

resource "aws_security_group_rule" "nodes_egress" {

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes.id
  cidr_blocks       = ["0.0.0.0/0"]
}
