data "aws_iam_policy_document" "vpc" {
  count = var.create_vpc_policy ? 1 : 0

  statement {
    sid       = "VPCManagementAccess"
    effect    = "Allow"
    actions   = var.vpc_policy_actions
    resources = var.vpc_policy_resources
  }
}

resource "aws_iam_policy" "vpc" {
  count = var.create_vpc_policy ? 1 : 0

  name        = "${var.name_prefix}-vpc-policy"
  description = "VPC management policy managed by Terraform"
  policy      = data.aws_iam_policy_document.vpc[0].json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name_prefix}-vpc-policy"
    }
  )
}
