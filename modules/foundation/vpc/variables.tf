variable "environment" {
  description = "Deployment environment name"
  type        = string

  validation {
    condition     = length(trimspace(var.environment)) > 0
    error_message = "Environment must not be empty."
  }
}


variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  validation {

    condition = can(cidrnetmask(var.vpc_cidr))

    error_message = "Invalid VPC CIDR."

  }
}

variable "availability_zones" {

  description = "Availability Zones"

  type = list(string)

  validation {

    condition = length(var.availability_zones) >= 2

    error_message = "At least 2 availability zones are required."

  }

  validation {
    condition     = length(var.availability_zones) == length(distinct(var.availability_zones))
    error_message = "Availability zones must be unique."
  }

}

variable "public_subnet_cidrs" {
  description = "Public Subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) >= 2
    error_message = "At least 2 public subnet CIDRs are required."
  }

  validation {
    condition = alltrue([
      for cidr in var.public_subnet_cidrs : can(cidrnetmask(cidr))
    ])
    error_message = "All public subnet CIDRs must be valid."
  }
}

variable "private_subnet_cidrs" {
  description = "Private Subnet CIDRs"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) >= 2
    error_message = "At least 2 private subnet CIDRs are required."
  }

  validation {
    condition = alltrue([
      for cidr in var.private_subnet_cidrs : can(cidrnetmask(cidr))
    ])
    error_message = "All private subnet CIDRs must be valid."
  }
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
  default     = {}
}

variable "public_subnet_tags" {
  description = "Additional tags for public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for private subnets"
  type        = map(string)
  default     = {}

}


variable "project_name" {

  description = "Project name"

  type = string

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "Project name must not be empty."
  }

}

variable "enable_dns_hostnames" {

  description = "Enable DNS hostnames"

  type = bool

}


variable "enable_dns_support" {

  description = "Enable DNS support"

  type = bool

}

variable "instance_tenancy" {

  description = "VPC tenancy"

  type = string

  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be default, dedicated, or host."
  }
}

variable "single_nat_gateway" {

  description = "Create single NAT Gateway or one per AZ"

  type = bool

}

variable "map_public_ip_on_launch" {

  description = "Assign public IP on public subnet"

  type = bool

}
