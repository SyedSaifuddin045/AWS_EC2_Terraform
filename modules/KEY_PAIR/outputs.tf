output "key_name" {
  description = "Name of the AWS key pair"
  value       = aws_key_pair.generated_key.key_name
}

output "private_key_path" {
  description = "Path to the private key file"
  value       = "${path.root}/${aws_key_pair.generated_key.key_name}.pem"
}
