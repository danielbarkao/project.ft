resource "aws_route_table"  jenkins_route_table{
  vpc_id = aws_vpc.jenkins_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_internet_gatway.id
  }

  route {
    cidr_block = "10.1.0.0/16"
    nat_gateway_id = aws_nat_gateway.jenkins_nat_gateway.id
  }

  tags = {
    Name = "example-route-table"
  }
}
resource "aws_internet_gateway" "jenkins_internet_gatway" {
  vpc_id =  aws_vpc.jenkins_vpc.id

  tags = {
    Name = "example-internet-gateway"
  }
}
resource "aws_eip" "eip" {
  vpc = true
}
resource "aws_nat_gateway" "jenkins_nat_gateway" {
   allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "jenkins_nat_gateway-nat-gateway"
  }
}
