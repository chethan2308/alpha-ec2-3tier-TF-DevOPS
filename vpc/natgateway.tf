resource "aws_nat_gateway" "alpha_nat_az1" {

  allocation_id = aws_eip.alpha-eip-az1.id
  subnet_id     = aws_subnet.public_subnet_AZ1.id
  depends_on    = [aws_internet_gateway.alpha-igw]
}

resource "aws_nat_gateway" "alpha_nat_az2" {

  allocation_id = aws_eip.alpha-eip-az2.id
  subnet_id     = aws_subnet.public_subnet_AZ2.id
  depends_on    = [aws_internet_gateway.alpha-igw]

}

resource "aws_eip" "alpha-eip-az1" {

  domain = "vpc"

}

resource "aws_eip" "alpha-eip-az2" {

  domain = "vpc"

}

resource "aws_route_table" "alpha-private-route-az1" {
  vpc_id = aws_vpc.alpha-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.alpha_nat_az1.id
  }
}

resource "aws_route_table" "alpha-private-route-alpha_nat_az2" {
  vpc_id = aws_vpc.alpha-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.alpha_nat_az2.id
  }
}

resource "aws_route_table_association" "alpha-private-route-aws_route_table_association-app-az1" {
  subnet_id      = aws_subnet.private_app_subnet_AZ1.id
  route_table_id = aws_route_table.alpha-private-route-az1.id
}

resource "aws_route_table_association" "alpha-private-route-aws_route_table_association-private_data_subnet_AZ1" {
  subnet_id      = aws_subnet.private_data_subnet_AZ1.id
  route_table_id = aws_route_table.alpha-private-route-az1.id
}

resource "aws_route_table_association" "alpha-private-route-aws_route_table_association-private_app_subnet_az2" {
  subnet_id      = aws_subnet.private_app_subnet_AZ2.id
  route_table_id = aws_route_table.alpha-private-route-alpha_nat_az2.id
}

resource "aws_route_table_association" "alpha-private-route-aws_route_table_association-private_data_subnet_az2" {
  subnet_id      = aws_subnet.private_data_subnet_AZ2.id
  route_table_id = aws_route_table.alpha-private-route-az1.id
}








