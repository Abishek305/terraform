# dev values
aws_region         = "us-east-1"
vpc_cidr_block     = "192.168.0.0/16"
public_subnet_1_cidr = "192.168.10.0/24"
public_subnet_2_cidr = "192.168.20.0/24"
availability_zone_1  = "us-east-1a"
availability_zone_2  = "us-east-1b"
environment          = "dev"
cluster_name         = "dev-cluster"
cluster_version      = "1.30"
node_name            = "dev-node-group"
min_size             = 1
max_size             = 2
desired_size         = 1
instance_types       = ["t2.medium"]
disk_size            = 30

ecr_repository_name  = "my-ecr-repo"
image_tag_mutability = "MUTABLE"
scan_on_push         = "true"

iam_access_entries = [
#  {
#    policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
#    principal_arn = "arn:aws:iam::841162696396:user/terraform"
#  },
   {
     policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
     principal_arn = "arn:aws:iam::841162696396:user/terraform_test_1"
   }
]
