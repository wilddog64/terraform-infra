# Create the VPC
resource "aws_vpc" "cloud" {
  cidr_block = "10.0.1.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}

# Create the public subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.cloud.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
}

# Create the private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.cloud.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
}

# Create the internet gateway
resource "aws_internet_gateway" "cloud" {
  vpc_id = aws_vpc.cloud.id
}

# Attach the internet gateway to the VPC
resource "aws_vpc_attachment" "cloud" {
  vpc_id             = aws_vpc.cloud.id
  internet_gateway_id = aws_internet_gateway.cloud.id
}

# Create a route table and add a route to the internet gateway
resource "aws_route_table" "cloud" {
  vpc_id = aws_vpc.cloud.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloud.id
  }
}