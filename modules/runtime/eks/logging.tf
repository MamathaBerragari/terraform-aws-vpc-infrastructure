resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${var.cluster_name}/cluster"

  retention_in_days = 30

  kms_key_id = var.kms_key_arn

  tags = local.common_tags

}
