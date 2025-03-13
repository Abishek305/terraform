# Create managed eks cluster

resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version = var.cluster_version

  vpc_config {
    security_group_ids = [
        aws_security_group.eks_cluster-sg.id,
        aws_security_group.eks_nodes-sg.id
    ]
    subnet_ids = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access = true
  }

  tags = {
    Name = var.cluster_name
    Environment = var.environment
    "alpha.eksctl.io/cluster-oidc-enabled" = "true"
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_security_group.eks_cluster-sg, aws_security_group.eks_nodes-sg
  ]
}

# EKS cluster IAM Role

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.environment}-eks-cluster-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}


# EKS cluster security group 
resource "aws_security_group" "eks_cluster-sg" {
  name        = "${var.environment}-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.environment}-cluster-sg"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group_rule" "cluster_inbound" {
  description              = "Allow worker nodes to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster-sg.id
  source_security_group_id = aws_security_group.eks_nodes-sg.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster_outbound" {
  description              = "Allow cluster API Server to communicate with the worker nodes"
  from_port                = 1024
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster-sg.id
  source_security_group_id = aws_security_group.eks_nodes-sg.id
  to_port                  = 65535
  type                     = "egress"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name = "kube-proxy"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name = "vpc-cni"
}

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name = "eks-pod-identity-agent"
}


