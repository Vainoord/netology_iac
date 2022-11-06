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

resource "aws_network_interface" "aws_ec2_iface" {
  subnet_id   = aws_subnet.test_subnet.id
  #security_groups = ["sg-0b155e42ee1714fbc"]
  security_groups = [aws_security_group.tf_servers.id]
  #private_ips = ["192.168.110.11"]

  tags = {
    Name = "primary_network_interface"
  }
}


