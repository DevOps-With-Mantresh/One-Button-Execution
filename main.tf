module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  cluster_name = var.cluster_name
}

module "eks" {
  source          = "./modules/eks"
  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

resource "aws_vpc_peering_connection" "jenkins_peer" {
  vpc_id      = module.vpc.vpc_id
  peer_vpc_id = var.jenkins_vpc_id
  auto_accept = true

  tags = {
    Name = "jenkins-to-eks"
  }
}

resource "aws_route" "eks_to_jenkins" {
  for_each = toset(module.vpc.private_route_table_ids)

  route_table_id            = each.value
  destination_cidr_block    = var.jenkins_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.jenkins_peer.id
}

resource "aws_route" "jenkins_to_eks" {
  route_table_id            = var.jenkins_route_table_id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.jenkins_peer.id
}

resource "aws_security_group_rule" "allow_jenkins_to_eks" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.jenkins_vpc_cidr]
  security_group_id = module.eks.cluster_security_group_id
}

module "ecr" {
  source = "./modules/ecr"
}