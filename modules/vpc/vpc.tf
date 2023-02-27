# Create the VPC

locals {
  public_az = keys(var.public_subnet_cidrblock)[0]
  // public_subnet_set = toset(var.public_subnet_cidrblock[local.public_subnet_az])
  public_subnet_set = {for s in var.public_subnet_cidrblock[local.public_az]: index(var.public_subnet_cidrblock[local.public_az], s) => s}
  private_az = keys(var.private_subnet_cidrblock)[0]
  // private_subnet_set = toset(var.private_subnet_cidrblock[local.private_subnet_az])
  private_subnet_set = {for s in var.private_subnet_cidrblock[local.private_az]: index(var.private_subnet_cidrblock[local.private_az], s) => s}
}

resource "aws_vpc" "cloud" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.environment}_application_vpc"
  }
}

# Create the public subnet
resource "aws_subnet" "public" {
  for_each = local.public_subnet_set

  vpc_id            = aws_vpc.cloud.id
  cidr_block        = each.value
  availability_zone = local.public_az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-${local.public_az}-${each.value}"
  }
}

# Create the private subnet
resource "aws_subnet" "private" {
  for_each = local.private_subnet_set

  vpc_id            = aws_vpc.cloud.id
  cidr_block        = each.value
  availability_zone = local.private_az

  tags = {
    Name = "${var.environment}-${local.private_az}-${each.value}"
  }
}

# Create the internet gateway
resource "aws_internet_gateway" "cloud" {
  vpc_id = aws_vpc.cloud.id

  tags = {
    Name = "${var.environment}_internet_gateway"
  }
}

// create NAT elastic IPs
resource "aws_eip" "nat" {
  vpc = true
  count = length(local.public_subnet_set)

  tags = {
    Name = "${var.environment}_nat_eip"
  }
}

resource "aws_nat_gateway" "public" {
  for_each = local.public_subnet_set

  allocation_id = index(aws_eip.nat.*.id, each.value)
  // subnet_id = element(aws_subnet.public.*.id, count.index)
  subnet_id = aws_subnet.public[each.key].id

  tags = {
    Name = "${var.environment}_public_nat_gw"
  }
}

# Create a route table and add a route to the internet gateway
resource "aws_route_table" "cloud" {
  for_each = aws_nat_gateway.public

  vpc_id = aws_vpc.cloud.id

  route {
    cidr_block = "0.0.0.0/0"
    // nat_gateway_id = index(aws_nat_gateway.public.*.id, count.index)
    nat_gateway_id = aws_nat_gateway.public[each.key].id
  }

  tags = {
    Name = "${var.environment}_public_rt"
  }
}

resource "aws_route_table_association" "public" {
  // count = length(aws_subnet.public)
  for_each = local.public_subnet_set

  subnet_id = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.cloud[each.key].id
}

resource "aws_route_table_association" "private" {
  // count = length(aws_subnet.public)
  for_each = local.private_subnet_set

  subnet_id = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.cloud[each.key].id
}
