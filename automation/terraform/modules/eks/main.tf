
# create EKS cluster

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name                   = var.cluster_name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true 
  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  control_plane_subnet_ids       = var.subnet_ids
  create_cluster_security_group  = true
  create_node_security_group     = true
  # cluster_additional_security_group_ids = var.additional_security_group_ids  
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  eks_managed_node_group_defaults = {
    disk_size = var.disk_size
  }
  

  eks_managed_node_groups = {
    test = {
      node_name      = var.node_name
      ami_type       = "AL2_x86_64"
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_size
      instance_types = var.instance_types
      # node_security_group_ids = var.additional_security_group_ids
      attach_cluster_primary_security_group = false
      update_config = {
        max_unavailable = 1
        }
      
      create_launch_template = true
      launch_template_name   = ""
      launch_template = {
        name_prefix             = "custom-launch-template"
        enable_monitoring       = true
        instance_market_options = {
          market_type = "on-demand"
        }
      }
      lifecycle = {
      create_before_destroy = true
      }
    }
  }
}



