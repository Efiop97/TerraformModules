resource "aws_internet_gateway" "internet_gw" {

  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public" {
  count                   = var.SubnetCount
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Igor-Terra-${count.index + 1}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.all_traffic
    gateway_id = aws_internet_gateway.internet_gw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = var.SubnetCount
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.route_table.id
}
