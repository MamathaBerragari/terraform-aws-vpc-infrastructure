resource "aws_iam_openid_connect_provider" "this" {
  count = var.create_oidc_provider ? 1 : 0

  url = coalesce(
    var.oidc_provider_url,
    "https://invalid.example.com"
  )

  client_id_list = var.oidc_client_id_list

  thumbprint_list = length(var.oidc_thumbprint_list) > 0 ? (
    var.oidc_thumbprint_list
    ) : [
    "0000000000000000000000000000000000000000"
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.name_prefix}-oidc"
    }
  )

  lifecycle {
    precondition {
      condition = (
        var.oidc_provider_url != null &&
        length(var.oidc_client_id_list) > 0 &&
        length(var.oidc_thumbprint_list) > 0
      )
      error_message = "OIDC URL, client IDs and thumbprints are required when create_oidc_provider is true."
    }
  }
}
