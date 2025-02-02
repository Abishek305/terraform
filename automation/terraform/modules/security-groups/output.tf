output "security_group_id" {
  description = "The ID of the additional EKS security group"
  value       = aws_security_group.eks_additional_sg.id
}
