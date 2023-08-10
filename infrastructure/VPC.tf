
resource "aws_vpc" "jenkins_vpc" {
cidr_block = "10.0.0.0/16"
enable_dns_hostnames    = true
tags      = {
Name    = "Test_VPC"
}
}


resource "aws_subnet" "public-subnet" {
vpc_id                  = aws_vpc.jenkins_vpc.id
cidr_block              = "10.0.2.0/24"
availability_zone       = "us-west-2c"
map_public_ip_on_launch = true
tags      = {
Name    = "public-subnet"
}
}

resource "aws_route_table" "public-route-table" {
vpc_id       = aws_vpc.jenkins_vpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.jenkins_internet_gatway.id
}
tags       = {
Name     = "Public Route Table"
}
}


resource "aws_route_table_association" "public-subnet-1-route-table-association" {
subnet_id           = aws_subnet.public-subnet.id
route_table_id      = aws_route_table.public-route-table.id
lifecycle {
    ignore_changes = [subnet_id]
  }
}