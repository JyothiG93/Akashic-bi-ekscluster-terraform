resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = var.enable
  tags = {
    Name = var.vpcname
  }
}
resource "aws_subnet" "public-subnet" {
  count             = length(var.publicsubnet-cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.publicsubnet-cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "eks-igw"
  }
}
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "eks-public-route"
  }
}
resource "aws_route_table_association" "public-ra" {
  count          = length(var.publicsubnet-cidrs)
  subnet_id      = aws_subnet.public-subnet.*.id[count.index]
  route_table_id = aws_route_table.public-route.id
}
resource "aws_subnet" "private-subnet" {
  count             = length(var.privatesubnet-cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.privatesubnet-cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "eks-nat-eip"
  }
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet.0.id

  tags = {
    Name = "eks-nat"
  }
}
resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "eks-private-route"
  }

}
resource "aws_route_table_association" "private-ra" {
  count          = length(var.privatesubnet-cidrs)
  subnet_id      = aws_subnet.private-subnet.*.id[count.index]
  route_table_id = aws_route_table.private-route.id
}