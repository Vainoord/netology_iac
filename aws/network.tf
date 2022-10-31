resource "aws_vpc" "test_network" {
  cidr_block = "192.168.110.0/24"
  
  tags = {
    Name = "network_example"
  }
}

resource "aws_subnet" "test_subnet" {
  vpc_id            = aws_vpc.test_network.id
  cidr_block        = "192.168.110.0/26"
  availability_zone = var.aws_zone_residence

  tags = {
    Name = "subnet_example"
  }
}

resource "aws_network_interface" "test_iface" {
  subnet_id   = aws_subnet.test_subnet.id
  private_ips = ["192.168.110.11"]

  tags = {
    Name = "primary_network_interface"
  }
}

