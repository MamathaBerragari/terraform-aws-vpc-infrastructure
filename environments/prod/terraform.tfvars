aws_region = "ap-south-1"

environment = "prod"

vpc_cidr = "10.20.0.0/16"


availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]


public_subnet_cidrs = [
  "10.20.1.0/24",
  "10.20.2.0/24"
]


private_subnet_cidrs = [
  "10.20.11.0/24",
  "10.20.12.0/24"
]


cluster_name = "prod-eks"

node_group_name = "default"

desired_size = 3
min_size     = 2
max_size     = 5
