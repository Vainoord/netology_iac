data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "current_region" {
  value = var.aws_region
}

output "IPv4_ec2_instance" {
  value = aws_instance.aws_test_ec2.*.private_ip
}

output "IPv4_ec2_subnet_id" {
  value = aws_subnet.test_subnet.*.id
}
