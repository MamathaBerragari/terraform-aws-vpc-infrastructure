variable "environment" {
  type        = string
  description = "Deployment environment name, such as test or prod."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block."
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDR blocks."
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDR blocks."
}

variable "vpc_endpoints" {
  description = "Map of Gateway or Interface VPC endpoints."

  type = map(object({
    service_name        = string
    vpc_endpoint_type   = optional(string, "Gateway")
    private_dns_enabled = optional(bool)
    subnet_ids          = optional(list(string), [])
    security_group_ids  = optional(list(string), [])
    route_table_ids     = optional(list(string), [])
    policy              = optional(string)
    tags                = optional(map(string), {})
  }))

  default = {}

  validation {
    condition = alltrue([
      for endpoint in values(var.vpc_endpoints) :
      contains(
        [
          "Gateway",
          "Interface"
        ],
        endpoint.vpc_endpoint_type
      )
    ])

    error_message = "vpc_endpoint_type must be Gateway or Interface."
  }
}
