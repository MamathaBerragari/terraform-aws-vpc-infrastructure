variable "aws_region" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "availability_zones" {
  type = list(string)
}


variable "cluster_name" {
  type = string
}


variable "node_group_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_dns_support" {
  type = bool
}

variable "instance_tenancy" {
  type = string
}

variable "single_nat_gateway" {
  type = bool
}

variable "map_public_ip_on_launch" {
  type = bool
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "interface_endpoints" {
  description = "AWS Interface VPC Endpoint services"
  type        = list(string)
}

variable "gateway_endpoints" {
  description = "AWS Gateway VPC Endpoint services"
  type        = list(string)
}

variable "private_dns_enabled" {
  description = "Enable private DNS for Interface VPC Endpoints"
  type        = bool
}

variable "endpoint_egress_cidrs" {
  description = "CIDRs allowed for Interface VPC Endpoint egress"
  type        = list(string)
}

variable "ecr_repository_name" {
  description = "ECR repository name for the environment."
  type        = string
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability."
  type        = string
  default     = "IMMUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable ECR image scanning on push."
  type        = bool
  default     = true
}

variable "ecr_lifecycle_max_image_count" {
  description = "Maximum ECR images to retain."
  type        = number
  default     = 20
}

variable "ecr_repository_read_principals" {
  description = "IAM principals allowed to pull from ECR."
  type        = list(string)
  default     = []
}

variable "ecr_repository_write_principals" {
  description = "IAM principals allowed to push to ECR."
  type        = list(string)
  default     = []
}
