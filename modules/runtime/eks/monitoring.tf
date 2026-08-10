resource "aws_cloudwatch_metric_alarm" "cpu_high" {

  alarm_name = "${var.cluster_name}-high-cpu"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EKS"

  period = 300

  statistic = "Average"

  threshold = 80

  alarm_description = "High CPU utilization on EKS cluster"

  treat_missing_data = "notBreaching"

}
resource "aws_cloudwatch_log_group" "eks" {

  name = "/aws/eks/${var.cluster_name}/cluster"

  retention_in_days = 30

  tags = local.common_tags

}
