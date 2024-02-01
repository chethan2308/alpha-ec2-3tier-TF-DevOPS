resource "aws_vpc" "alpha-vpc" {

  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "alpha-vpc-dev"
  }
}

resource "aws_internet_gateway" "alpha-igw" {
  vpc_id = aws_vpc.alpha-vpc.id

  tags = {
    Name = "alpha-igw-dev"
  }
}

resource "aws_subnet" "public_subnet_AZ1" {
  vpc_id                  = aws_vpc.alpha-vpc.id
  cidr_block              = var.public_subnet_AZ1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_AZ2" {
  vpc_id                  = aws_vpc.alpha-vpc.id
  cidr_block              = var.public_subnet_AZ2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "internet_route" {
  vpc_id = aws_vpc.alpha-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.alpha-igw.id
  }
}

resource "aws_route_table_association" "aws_route_table_association_az1" {
  route_table_id = aws_route_table.internet_route.id
  subnet_id      = aws_subnet.public_subnet_AZ1.id

}

resource "aws_route_table_association" "aws_route_table_association_az2" {
  route_table_id = aws_route_table.internet_route.id
  subnet_id      = aws_subnet.public_subnet_AZ2.id

}


resource "aws_subnet" "private_app_subnet_AZ1" {
  vpc_id                  = aws_vpc.alpha-vpc.id
  cidr_block              = var.private_app_subnet_az1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_app_subnet_AZ2" {
  vpc_id                  = aws_vpc.alpha-vpc.id
  cidr_block              = var.private_app_subnet_az2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_data_subnet_AZ1" {
  vpc_id                  = aws_vpc.alpha-vpc.id
  cidr_block              = var.private_data_subnet_az1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
}


resource "aws_subnet" "private_data_subnet_AZ2" {
  vpc_id                  = aws_vpc.alpha-vpc.id
  cidr_block              = var.private_data_subnet_az2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
}