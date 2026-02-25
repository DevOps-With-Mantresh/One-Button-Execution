module "vpc" {
  source = "./modules/vpc"

  cluster_name = var.cluster_name
  vpc_cidr     = var.vpc_cidr
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  private_subnets = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"
}