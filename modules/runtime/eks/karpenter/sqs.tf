resource "aws_sqs_queue" "interruption_queue" {

  name = "${var.cluster_name}-karpenter"

}
