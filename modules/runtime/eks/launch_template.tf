resource "aws_launch_template" "nodes" {

  name_prefix = "${var.cluster_name}-lt-"

  update_default_version = true

  vpc_security_group_ids = [
    aws_security_group.nodes.id
  ]

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

  }

  monitoring {

    enabled = true

  }

  tag_specifications {

    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${var.cluster_name}-worker"
      }
    )

  }

}
