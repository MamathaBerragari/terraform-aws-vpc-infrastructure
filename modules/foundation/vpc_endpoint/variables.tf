variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where endpoints will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for Interface VPC Endpoints"
  type        = list(string)
}

variable "private_route_table_ids" {
  description = "Private route table IDs for Gateway VPC Endpoints"
  type        = list(string)
}

variable "interface_endpoints" {
  description = "AWS service names requiring Interface VPC Endpoints"
  type        = list(string)

  validation {
    condition     = length(var.interface_endpoints) == length(distinct(var.interface_endpoints))
    error_message = "Interface endpoint service names must be unique."
  }
}

variable "gateway_endpoints" {
  description = "AWS service names requiring Gateway VPC Endpoints"
  type        = list(string)

  validation {
    condition     = length(var.gateway_endpoints) == length(distinct(var.gateway_endpoints))
    error_message = "Gateway endpoint service names must be unique."
  }
}

variable "private_dns_enabled" {
  description = "Enable private DNS for Interface VPC Endpoints"
  type        = bool
}

variable "endpoint_ingress_cidrs" {
  description = "CIDRs allowed to access Interface VPC Endpoints"
  type        = list(string)
}

variable "endpoint_egress_cidrs" {
  description = "CIDRs allowed for Interface VPC Endpoint egress"
  type        = list(string)
}

variable "endpoint_port" {
  description = "Port used by Interface VPC Endpoints"
  type        = number
}

variable "endpoint_protocol" {
  description = "Protocol used by Interface VPC Endpoint ingress"
  type        = string
}

variable "endpoint_ingress_description" {
  description = "Description for Interface VPC Endpoint ingress"
  type        = string
}

variable "endpoint_egress_description" {
  description = "Description for Interface VPC Endpoint egress"
  type        = string
}

variable "endpoint_egress_from_port" {
  description = "Starting port for Interface VPC Endpoint egress"
  type        = number
}

variable "endpoint_egress_to_port" {
  description = "Ending port for Interface VPC Endpoint egress"
  type        = number
}

variable "endpoint_egress_protocol" {
  description = "Protocol for Interface VPC Endpoint egress"
  type        = string
}

variable "security_group_description" {
  description = "Description for the Interface VPC Endpoint security group"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
