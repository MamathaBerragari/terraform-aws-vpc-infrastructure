data "aws_iam_policy_document" "karpenter_controller_assume" {

  statement {

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        var.oidc_provider_arn
      ]
    }

    condition {
      test = "StringEquals"

      variable = "${replace(var.oidc_provider_url, "https://", "")}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

  }

}


resource "aws_iam_role" "karpenter_controller" {

  name = "${var.cluster_name}-karpenter-controller"

  assume_role_policy = data.aws_iam_policy_document.karpenter_controller_assume.json

}


resource "aws_iam_role_policy_attachment" "karpenter_controller" {

  role = aws_iam_role.karpenter_controller.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"

}


resource "aws_iam_role" "karpenter_node" {

  name = "${var.cluster_name}-karpenter-node"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [{

      Effect = "Allow"

      Principal = {
        Service = "ec2.amazonaws.com"
      }

      Action = "sts:AssumeRole"

    }]

  })

}


resource "aws_iam_role_policy_attachment" "karpenter_worker" {

  role = aws_iam_role.karpenter_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

}


resource "aws_iam_role_policy_attachment" "karpenter_cni" {

  role = aws_iam_role.karpenter_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

}


resource "aws_iam_role_policy_attachment" "karpenter_ecr" {

  role = aws_iam_role.karpenter_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

}

resource "aws_iam_role_policy_attachment" "karpenter_ssm" {

  role = aws_iam_role.karpenter_node.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

resource "aws_iam_role_policy_attachment" "karpenter_ebs" {

  role = aws_iam_role.karpenter_node.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

}

resource "aws_iam_role_policy" "karpenter_controller_eks" {
  name = "karpenter-controller-eks"

  role = aws_iam_role.karpenter_controller.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "eks:DescribeCluster"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "karpenter_controller_permissions" {

  name = "karpenter-controller-permissions"

  role = aws_iam_role.karpenter_controller.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "ec2:*",
          "ssm:GetParameter",
          "pricing:GetProducts"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "iam:GetInstanceProfile",
          "iam:CreateInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:DeleteInstanceProfile",
          "iam:TagInstanceProfile",
          "iam:PassRole"
        ]

        Resource = "*"
      }

    ]
  })
}

resource "aws_iam_instance_profile" "karpenter_node" {

  name = "${var.cluster_name}-karpenter-node"

  role = aws_iam_role.karpenter_node.name

}
