############################################################
# EKS CloudWatch CPU Alarm
############################################################

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name = "${var.cluster_name}${var.cpu_alarm_name_suffix}"

  comparison_operator = var.cpu_alarm_comparison_operator
  evaluation_periods  = var.cpu_alarm_evaluation_periods
  metric_name         = var.cpu_alarm_metric_name
  namespace           = var.cpu_alarm_namespace
  period              = var.cpu_alarm_period
  statistic           = var.cpu_alarm_statistic
  threshold           = var.cpu_alarm_threshold

  alarm_description  = var.cpu_alarm_description
  treat_missing_data = var.cpu_alarm_treat_missing_data
}

############################################################
# EKS CloudWatch Log Group
############################################################

resource "aws_cloudwatch_log_group" "eks" {
  name              = "${var.eks_log_group_name_prefix}${var.cluster_name}${var.eks_log_group_name_suffix}"
  retention_in_days = var.eks_log_retention_in_days

  tags = local.common_tags
}
