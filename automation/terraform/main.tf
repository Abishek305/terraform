
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = "~> 2.22.0"
#     }
#   }
# }

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# AWS VPC

module "vpc" {
  source               = "./module/vpc"
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
  environment          = var.environment
  cluster_name         = var.cluster_name
}

# AWS SECURITY GROUP

# module "security-group" {
#   source      = "./module/security-groups"
#   vpc_id      = module.vpc.vpc_id
#   environment = var.environment
# }

# AWS EKS

module "eks" {
  source                        = "./module/eks"
  cluster_name                  = var.cluster_name
  cluster_version               = var.cluster_version
  vpc_id                        = module.vpc.vpc_id
  subnet_ids                    = module.vpc.private_subnet_ids
  node_group_name               = var.node_name
  instance_types                = var.instance_types
  min_size                      = var.min_size
  max_size                      = var.max_size
  desired_size                  = var.desired_size
  disk_size                     = var.disk_size
  ami_type                      = var.ami_type
  capacity_type                 = var.capacity_type
  environment                   = var.environment
}

# AWS ECR

module "ecr" {
  source               = "./module/ecr"
  ecr_repository_name  = var.ecr_repository_name
  image_tag_mutability = var.image_tag_mutability
  scan_on_push         = var.scan_on_push
}

