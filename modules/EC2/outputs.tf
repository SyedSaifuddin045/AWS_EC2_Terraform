output "ec2_public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "The public IP address of the EC2 instance"
}

