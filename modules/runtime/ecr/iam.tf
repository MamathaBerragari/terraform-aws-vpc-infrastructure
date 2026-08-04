data "aws_iam_policy_document" "ecr_access" {

  statement {

    sid = "ECRAccess"

    effect = "Allow"

    actions = [

      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"

    ]

    resources = [

      aws_ecr_repository.this.arn

    ]

  }

}

resource "aws_iam_policy" "ecr" {

  name = "${local.repository_name}-policy"

  description = "IAM Policy for ECR Repository"

  policy = data.aws_iam_policy_document.ecr_access.json

}
