variable "vpc_id" {
  description = "VPC to create the subnet in"
  type        = string
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/28"
}
