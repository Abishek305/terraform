output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

# output "eks_cluster_endpoint" {
#   description = "The endpoint of the EKS cluster"
#   value       = module.eks.eks_cluster_endpoint
# }

# output "eks_cluster_arn" {
#   description = "The ARN of the EKS cluster"
#   value       = module.eks.eks_cluster_arn
# }

# output "eks_additional_security_group_id" {
#   description = "ID of the additional security group attached to the EKS cluster"
#   value       = module.security-group.security_group_id
# }

# output "eks_cluster_id" {
#   description = "The name of the EKS cluster"
#   value       = module.eks.eks_cluster_name
# }

