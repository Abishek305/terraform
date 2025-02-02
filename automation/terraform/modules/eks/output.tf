# Output EKS Cluster Name
output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

# Output EKS Cluster Endpoint
output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

# Output EKS Cluster ARN
output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

# # Output EKS Node Group Names
# output "eks_node_group_name" {
#   description = "The names of the managed node groups in the EKS cluster"
#   value       = module.eks.eks_managed_node_groups
# }

# # Output EKS Node Group ARNs
# output "eks_node_group_arns" {
#   description = "The ARNs of the managed node groups in the EKS cluster"
#   value       = module.eks.eks_managed_node_group_arns
# }

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

# output "cluster_id" {
#   description = "The ID of the EKS cluster"
#   value       = module.eks.eks_cluster_name
# }
