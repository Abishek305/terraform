variable "cluster_name" {
  description = "EKS cluster name"
  type = string
}

variable "cluster_version" {
  description = "EKS cluster version"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "node_group_name" {
  description = "EKS node group name"
  type = string
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = string
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
}

variable "desired_size" {
  description = "Node desired size"
  type        = number
}

variable "ami_type" {
  description = "AMI type for EKS managed node group"
  type = string
}

variable "capacity_type" {
  description = "Node group capacity"
  type = string
}

variable "disk_size" {
  description = "Disk size for worker nodes"
  type = number
}

variable "instance_types" {
  description = "Instance type for the worker node"
  type = list(string)
}
