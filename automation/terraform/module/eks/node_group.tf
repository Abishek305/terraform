# EKS Node Group

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

    scaling_config {
      desired_size = var.desired_size
      max_size     = var.max_size
      min_size     = var.min_size
    }

    ami_type       = var.ami_type
    capacity_type  = var.capacity_type
    disk_size      = var.disk_size
    instance_types = var.instance_types

    tags = {
      Name = var.node_group_name
      Environment = var.environment
    }

    depends_on = [
      aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
      aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
      aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
      aws_iam_role_policy_attachment.node_CloudWatchFullAccess,
    ]
}

# EKS Node group IAM role

resource "aws_iam_role" "eks_node_role" {
  name = "${var.environment}-worker-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "node_CloudWatchFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_policy" "autoscaler_policy" {
  name        = "${var.environment}-AutoscalerPolicy"
  description = "Autoscaler policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "node_EKSWorkerNodeAutoscalerPolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.autoscaler_policy.arn
}

# EKS Node security group

resource "aws_security_group" "eks_nodes-sg" {
  name = "${var.environment}-node-sg"
  description = "security group for all nodes in the cluster"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                         = "${var.environment}-node-sg"
    "kubernetes.io/cluster/${var.environment}-cluster"     = "owned"
    Environment   = var.environment
  }
}

resource "aws_security_group_rule" "nodes_internal" {
  description              = "Allow nodes to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes-sg.id
  source_security_group_id = aws_security_group.eks_nodes-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "nodes_cluster_inbound" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes-sg.id
  source_security_group_id = aws_security_group.eks_cluster-sg.id
  to_port                  = 65535
  type                     = "ingress"
}
