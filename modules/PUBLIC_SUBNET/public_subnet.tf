resource "aws_subnet" "public_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block

  tags = {
    Name = "Public_Subnet_EC2"
  }
}
