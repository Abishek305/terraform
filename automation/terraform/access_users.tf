#resource "aws_eks_access_entry" "eks_access_entry" {
#  for_each      = { for entry in var.iam_access_entries : entry.principal_arn => entry }
#  cluster_name  = module.eks.cluster_name # ensure that eks cluster is created with name eks
#  principal_arn = each.value.principal_arn
#  type          = "STANDARD"
#}

#resource "aws_eks_access_policy_association" "eks_policy_association" {
#  for_each      = { for entry in var.iam_access_entries : entry.principal_arn => entry }
#  cluster_name  = module.eks.cluster_name # ensure that eks cluster is created with name eks
#  policy_arn    = each.value.policy_arn
#  principal_arn = each.value.principal_arn

#  access_scope {
#    type = "cluster"
#  }
#}
