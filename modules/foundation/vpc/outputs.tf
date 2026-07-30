output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}

output "vpc_arn" {
  value       = aws_vpc.main.arn
  description = "The ARN of the VPC."
}

output "public_subnet_ids" {
  value       = [for subnet in aws_subnet.public : subnet.id]
  description = "List of public subnet IDs."
}

output "private_subnet_ids" {
  value       = [for subnet in aws_subnet.private : subnet.id]
  description = "List of private subnet IDs."
}

output "public_route_table_id" {
  value       = aws_route_table.public_rt.id
  description = "ID of the public route table."
}

output "private_route_table_ids" {
  value       = [for route_table in aws_route_table.private_rt : route_table.id]
  description = "List of private route table IDs."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "ID of the Internet Gateway."
}

output "nat_gateway_ids" {
  value       = [for nat_gateway in aws_nat_gateway.nat : nat_gateway.id]
  description = "List of NAT Gateway IDs."
}

output "nat_gateway_ips" {
  value       = [for eip in aws_eip.nat : eip.public_ip]
  description = "Public IP addresses of the NAT Gateways."
}

output "vpc_endpoint_ids" {
  description = "Map of VPC endpoint names to endpoint IDs."

  value = {
    for name, endpoint in aws_vpc_endpoint.this :
    name => endpoint.id
  }
}

output "vpc_endpoint_arns" {
  description = "Map of VPC endpoint names to endpoint ARNs."

  value = {
    for name, endpoint in aws_vpc_endpoint.this :
    name => endpoint.arn
  }
}
