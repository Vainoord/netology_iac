# Configure the AWS Provider
provider "aws" {
  region = var.aws_default_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

###
# Define instance with determined COUNT
###
resource "aws_instance" "aws_ec2_tf_v1" {
  ami = data.aws_ami.latest_ubuntu.id
  vpc_security_group_ids = [aws_security_group.tf_servers.id]
  instance_type = local.aws_instance_type_map[terraform.workspace]
  count = local.aws_instance_count_map[terraform.workspace]
  subnet_id = aws_subnet.test_subnet.id
  tags = {
    Name = "Ubuntu_ec2"
  }
  
  #network_interface {
  #  network_interface_id = aws_network_interface.aws_ec2_iface.id
  #  device_index = 0
  #}

  lifecycle {
    create_before_destroy = true
  }
}

###
# Define instance using FOR_EACH
###
resource "aws_instance" "aws_ec2_tf_v2" {
  for_each = local.aws_instances_list
  ami = each.value
  instance_type = each.key
  vpc_security_group_ids = [aws_security_group.tf_servers.id]
  subnet_id = aws_subnet.test_subnet.id
  tags = {
    Name = "Amazon_ec2"
  }

  #network_interface {
  #  network_interface_id = aws_network_interface.aws_ec2_iface.id
  #  device_index = 0
  #}

  lifecycle {
    create_before_destroy = true
  }
}


