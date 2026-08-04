resource "aws_db_subnet_group" "this" {

  name = "${local.name}-subnet-group"

  subnet_ids = var.private_subnet_ids

  description = "Private subnet group for RDS"

  tags = local.common_tags
}
