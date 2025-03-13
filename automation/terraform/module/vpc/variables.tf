# CIDR block for the VPC
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

# Public Subnet 1 CIDR block
variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "192.168.1.0/24"
}

# Public Subnet 2 CIDR block
variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "192.168.2.0/24"
}

# Private Subnet 1 CIDR block
variable "private_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "192.168.3.0/24"
}

# Private Subnet 2 CIDR block
variable "private_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "192.168.4.0/24"
}

# Availability Zones
variable "availability_zone_1" {
  description = "First availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Second availability zone"
  type        = string
  default     = "us-east-1b"
}

# Environment name for tagging resources
variable "environment" {
  description = "Environment name for tagging resources"
  type        = string
  default     = "test"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster for tagging purposes"
  type        = string
}
