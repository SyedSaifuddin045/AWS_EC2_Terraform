variable "vpc_id" {
  description = "Required VPC id to create the route table in"
  type        = string
}
variable "internet_gateway_id" {
  type        = string
  description = "Internet Gateway ID for routing internet traffic"
}

variable "subnet_id" {
  type = string
}
