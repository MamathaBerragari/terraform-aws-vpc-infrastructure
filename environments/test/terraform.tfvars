aws_region = "ap-south-1"

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

cluster_name = "test-eks"

node_group_name = "default"

desired_size = 2
min_size     = 1
max_size     = 3
