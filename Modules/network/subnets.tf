resource "aws_internet_gateway" "my_igw" {

  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "igor_pub_terra" {
  count                   = var.SubnetCount
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr[count.index]
  availability_zone       = var.availabilityZones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "Igor-Terra-${count.index + 1}"
  }
}

resource "aws_route_table" "igor_terra_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.allTraffic
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_1_association" {
  count          = var.SubnetCount
  subnet_id      = aws_subnet.igor_pub_terra[count.index].id
  route_table_id = aws_route_table.igor_terra_route.id
}
