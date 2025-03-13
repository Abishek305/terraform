# Output VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.vpc.id
}

# Output Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output Public Subnet IDs
output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = [
    aws_subnet.public-subnet-1.id,
    aws_subnet.public-subnet-2.id
  ]
}

# Output Private Subnet IDs
output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = [
    aws_subnet.private-subnet-1.id,
    aws_subnet.private-subnet-2.id
  ]
}

# Output Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}
