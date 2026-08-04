resource "aws_iam_role_policy_attachment" "rds_monitoring" {

  role = aws_iam_role.enhanced_monitoring.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
