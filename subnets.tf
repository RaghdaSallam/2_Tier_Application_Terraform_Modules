resource "aws_subnet" "creating-subnets" {
   vpc_id=data.aws_vpc.vpc.id
  for_each = var.subnets
  availability_zone_id = each.value["availability_zone"]
  
  cidr_block = each.value["cidr-block"]
}

  resource "aws_internet_gateway" "gateway" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "raghda-gateway"
  }
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "raghda-routetable"
  }

}

resource "aws_route_table_association" "association" {

  subnet_id =  aws_subnet.creating-subnets["public_subnet"].id
  route_table_id = aws_route_table.public_subnet_route_table.id
}