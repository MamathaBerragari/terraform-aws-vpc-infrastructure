resource "aws_eks_cluster" "this" {

  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {

    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access

    security_group_ids = [
      aws_security_group.cluster.id
    ]

  }

  kubernetes_network_config {

    ip_family = "ipv4"

  }

  access_config {

    authentication_mode = "API_AND_CONFIG_MAP"

    bootstrap_cluster_creator_admin_permissions = true

  }

  enabled_cluster_log_types = var.enabled_log_types

  encryption_config {

    provider {

      key_arn = var.kms_key_arn

    }

    resources = ["secrets"]

  }

  tags = local.common_tags

}
