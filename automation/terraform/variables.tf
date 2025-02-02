variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "availability_zone_1" {
  description = "First availability zone"
  type        = string
}

variable "availability_zone_2" {
  description = "Second availability zone"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes cluster version"
  type        = string
}

variable "node_name" {
  description = "Name of the node group"
  type        = string
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
}

variable "instance_types" {
  description = "Instance types for EKS managed nodes"
  type        = list(string)
}

variable "disk_size" {
  description = "Disk size for EKS nodes"
  type        = number
}

variable "ecr_repository_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Options: MUTABLE or IMMUTABLE."
  type        = string
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository."
  type        = bool
}

variable "iam_users" {
  description = "List of IAM user names to grant EKS admin access"
  type        = list(string)
  default     = []
}

variable "iam_access_entries" {
  description = "List of IAM users and roles to grant access to the EKS cluster"
  type = list(object({
    policy_arn    = string
    principal_arn = string
  }))
}
