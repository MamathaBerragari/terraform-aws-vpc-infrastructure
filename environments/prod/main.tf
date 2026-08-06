module "vpc" {
  source = "../../modules/foundation/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
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

  cluster_name    = "prod-eks"
  node_group_name = "default"

  vpc_id = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids

  control_plane_subnet_ids = module.vpc.private_subnet_ids

  tags = {
    Environment = "prod"
    Project     = "terraform-project"
    ManagedBy   = "Terraform"
  }

}
