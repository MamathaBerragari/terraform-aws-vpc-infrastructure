output "controller_role_arn" {
  description = "Karpenter Controller IAM Role"

  value = aws_iam_role.karpenter_controller.arn
}

output "node_role_arn" {
  description = "Karpenter Node IAM Role"

  value = aws_iam_role.karpenter_node.arn
}

output "sqs_queue_url" {
  description = "Interruption Queue"

  value = aws_sqs_queue.interruption_queue.url
}
