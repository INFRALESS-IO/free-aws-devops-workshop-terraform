# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[0]
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[1]
  availability_zone = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet-2"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[0]
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[1]
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-2"
  }
}

# Secure Subnets
resource "aws_subnet" "secure_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.secure_subnet_cidrs[0]
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.project_name}-${var.environment}-secure-subnet-1"
  }
}

resource "aws_subnet" "secure_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.secure_subnet_cidrs[1]
  availability_zone = "${var.region}b"
  tags = {
    Name = "${var.project_name}-${var.environment}-secure-subnet-2"
  }
}

# NAT Gateway for the private subnet
resource "aws_eip" "nat" {
  domain = "vpc"
}


resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat"
  }
}

# Routing Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

# Associate Public Routing Table with Public Subnets
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}


# Routing Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-private-rt"
  }
}

# Associate Private Routing Table with Private Subnets
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}

# Routing Table for Secure Subnets
resource "aws_route_table" "secure" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-secure-rt"
  }
}

# Associate Secure Routing Table with Secure Subnets
resource "aws_route_table_association" "secure_1" {
  subnet_id      = aws_subnet.secure_subnet_1.id
  route_table_id = aws_route_table.secure.id
}

resource "aws_route_table_association" "secure_2" {
  subnet_id      = aws_subnet.secure_subnet_2.id
  route_table_id = aws_route_table.secure.id
}
