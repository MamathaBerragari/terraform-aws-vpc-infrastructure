output "interface_endpoint_ids" {
  description = "Map of Interface VPC Endpoint IDs"

  value = {
    for endpoint_name, endpoint in aws_vpc_endpoint.interface :
    endpoint_name => endpoint.id
  }
}

output "gateway_endpoint_ids" {
  description = "Map of Gateway VPC Endpoint IDs"

  value = {
    for endpoint_name, endpoint in aws_vpc_endpoint.gateway :
    endpoint_name => endpoint.id
  }
}

output "security_group_id" {
  description = "Security Group ID used by Interface VPC Endpoints"

  value = aws_security_group.this.id
}
