# dev values
aws_region           = "us-east-2"
vpc_cidr_block       = "193.168.0.0/16"
public_subnet_1_cidr  = "193.168.1.0/24"
public_subnet_2_cidr  = "193.168.2.0/24"
private_subnet_1_cidr = "193.168.3.0/24"
private_subnet_2_cidr = "193.168.4.0/24"
availability_zone_1  = "us-east-2a"
availability_zone_2  = "us-east-2b"
environment          = "devs"
cluster_name         = "devs-cluster"
cluster_version      = "1.30"
node_name            = "devs-node-group"
min_size             = 1
max_size             = 2
desired_size         = 1
instance_types       = ["t2.medium"]
disk_size            = 30
ami_type             = "AL2_x86_64"
capacity_type        = "ON_DEMAND"

ecr_repository_name  = "dev-de-test-repo"
image_tag_mutability = "MUTABLE"
scan_on_push         = "true"

iam_access_entries = [
  {
    policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    principal_arn = "arn:aws:iam::841162696396:user/terraform"
  },
   {
     policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
     principal_arn = "arn:aws:iam::841162696396:user/terraform_test_1"
   },
  # {
  #   policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  #   principal_arn = "arn:aws:iam::498173904455:role/devops-team-role"
  # }
]
