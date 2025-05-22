variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID to launch the EC2 instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of Security Group IDs to attach"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "Key pair name to associate with the instance"
  type        = string
  default     = null
}

variable "user_data" {
  description = "User data script to configure the instance on launch"
  type        = string
  default     = ""
}

