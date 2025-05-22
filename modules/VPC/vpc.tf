resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "VPC_EC2"
  }
}
