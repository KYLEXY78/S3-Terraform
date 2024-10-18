# VPC
resource "aws_vpc" "kuzan_vpc" {
  cidr_block           = var.vpc_cidr
  
  tags = {
    name = "devops-group-5"
  }
}

#Create the Subnet(s)

resource "aws_subnet" "kuzan_subnet" {
  vpc_id = aws_vpc.kuzan_vpc.id
  cidr_block = var.kuzan_subnet_cidr
  availability_zone = var.availability_zone
  
  tags = {
    name = "devops-group-5"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "kuzan_ig" {
  vpc_id = aws_vpc.kuzan_vpc.id
  
  tags = {
    name = "devops-group-5"
  }
}

#Create Route Tables

resource "aws_route_table" "kuzan_rt" { 
  vpc_id = aws_vpc.kuzan_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kuzan_ig.id
  }
  
  tags = {
    name = "devops-group-5"
  }
}


#Associate Public Subnet with the Public Route Table
resource "aws_route_table_association" "kuzan_rt_association" {
  subnet_id = aws_subnet.kuzan_subnet.id
  route_table_id = aws_route_table.kuzan_rt.id
}