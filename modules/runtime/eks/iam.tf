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
