module "vpc" {

  source = "../../modules/foundation/vpc"


  aws_region = var.aws_region

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_subnet_cidrs = var.private_subnet_cidrs

}

module "ecr" {

  source = "../../modules/runtime/ecr"

  repository_name = "my-application"


  tags = {
    Environment = "prod"
    Project     = "terraform-project"
    ManagedBy   = "Terraform"
  }

}

module "eks" {

  source = "../../modules/runtime/eks"

  cluster_name = var.cluster_name

  node_group_name = var.node_group_name


  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size


  vpc_id = module.vpc.vpc_id


  private_subnet_ids = module.vpc.private_subnet_ids


  control_plane_subnet_ids = module.vpc.private_subnet_ids


  tags = {
    Environment = var.environment
    Project     = "terraform-project"
    ManagedBy   = "Terraform"
  }

}
