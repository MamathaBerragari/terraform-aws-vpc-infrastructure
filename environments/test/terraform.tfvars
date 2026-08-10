aws_region = "ap-south-1"

project_name = "terraform-project"

environment = "test"

vpc_cidr = "10.10.0.0/16"


availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]


public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]


private_subnet_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24"
]

enable_dns_hostnames = true

enable_dns_support = true

instance_tenancy = "default"

single_nat_gateway = false

map_public_ip_on_launch = true

tags = {
  Project     = "terraform-project"
  Environment = "test"
}

public_subnet_tags = {}

private_subnet_tags = {}

cluster_name = "test-eks"

node_group_name = "default"

desired_size = 2

min_size = 1

max_size = 3

interface_endpoints = [
  "ecr.api",
  "ecr.dkr",
  "logs",
  "sts"
]

gateway_endpoints = [
  "s3"
]

private_dns_enabled = true

endpoint_egress_cidrs = [
  "0.0.0.0/0"
]

ecr_repository_name = "my-application-test"

ecr_image_tag_mutability      = "IMMUTABLE"
ecr_scan_on_push              = true
ecr_lifecycle_max_image_count = 20

ecr_repository_read_principals  = []
ecr_repository_write_principals = []
