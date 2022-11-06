###
# Create security group for my instances
###
resource "aws_security_group" "tf_servers" {
    name = "tf_servers_security_group"
    description = "Dynamic Security Group"
    # vpc_id from network.tf file
    vpc_id = aws_vpc.test_network.id

    dynamic "ingress" {
        for_each = ["80", "443", "8080"]
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "Dynamic Security Group"
    }
}
