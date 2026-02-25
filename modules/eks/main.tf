module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.35"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  enable_irsa = true

  cluster_addons = {
    coredns = {}
    kube-proxy = {}
    vpc-cni = {}
  }

  manage_aws_auth_configmap = false

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::575490177946:root"
      username = "admin-user"
      groups   = ["system:masters"]
    }
  ]

  eks_managed_node_groups = {
    default = {
      desired_size = 0
      min_size     = 0
      max_size     = 0

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }
}