# AWS region to deploy resources
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Environment name for tagging resources
variable "environment" {
  description = "Environment name for tagging resources"
  type        = string
  default     = "test"
}


# Kubernetes cluster name
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "test"
}

# Kubernetes cluster version
variable "cluster_version" {
  description = "Kubernetes cluster version"
  type        = string
  default     = "1.30"
}

# Instance types for EKS managed nodes
variable "instance_types" {
  description = "Instance types for EKS managed nodes"
  type        = list(string)
  default     = ["t2.medium"]
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = string
  default     = "1"
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = "1"
}

variable "desired_size" {
  description = "Node desired size"
  type        = number
  default     = "1"
}

variable "disk_size" {
  description = "Node disk size"
  type        = number
  default     = "20"
}

variable "max_unavailable" {
  description = "Maximum number of nodes unavailable"
  type        = number
  default     = "1"
}

# Kubernetes node group name
variable "node_name" {
  description = "Name of the node group"
  type        = string
  default     = "test_eks_node_group"
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "additional_security_group_ids" {
  description = "List of additional security groups to attach to the EKS cluster"
  type        = list(string)
}

