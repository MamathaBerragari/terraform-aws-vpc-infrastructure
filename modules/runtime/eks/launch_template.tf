resource "aws_launch_template" "nodes" {
  name_prefix            = "${var.cluster_name}${var.launch_template_name_suffix}"
  update_default_version = var.launch_template_update_default_version

  vpc_security_group_ids = [
    aws_security_group.nodes.id
  ]

  metadata_options {
    http_endpoint = var.launch_template_http_endpoint
    http_tokens   = var.launch_template_http_tokens
  }

  monitoring {
    enabled = var.launch_template_monitoring_enabled
  }

  tag_specifications {
    resource_type = var.launch_template_tag_resource_type

    tags = merge(
      local.common_tags,
      {
        Name = "${var.cluster_name}${var.worker_node_name_suffix}"
      }
    )
  }
}
