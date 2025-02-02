# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-igw"
    Environment = var.environment
  }
}

# private subnet 01

# resource "aws_subnet" "private-subnet-1" {
#   vpc_id            = aws_vpc.test-vpc.id
#   cidr_block        = "192.168.10.0/24"
#   availability_zone = "us-east-1a"

#   tags = {
#     Name                              = "private-subnet"
#     "kubernetes.io/role/internal-elb" = "1"
#     "kubernetes.io/cluster/${var.cluster_name}"      = "owned"
#   }
# }
# private subnet 02

# resource "aws_subnet" "private-subnet-2" {
#   vpc_id            = aws_vpc.test-vpc.id
#   cidr_block        = "192.168.1.0/24"
#   availability_zone = "us-east-1b"

#   tags = {
#     Name                              = "private-subnet"
#     "kubernetes.io/role/internal-elb" = "1"
#     "kubernetes.io/cluster/${var.cluster_name}"      = "owned"
#   }
# }

# public subnet 01

resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    Name                         = "${var.environment}-public-subnet-1"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment = var.environment
  }
}
# public subnet 02

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    Name                         = "${var.environment}-public-subnet-2"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.igw.id
    }

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route_table_association" "public-rt" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-rt1" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public.id
}