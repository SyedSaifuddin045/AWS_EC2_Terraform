resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ec2_instance_key"
  public_key = tls_private_key.key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  content  = tls_private_key.key.private_key_pem
  filename = "${path.root}/${aws_key_pair.generated_key.key_name}.pem"

  file_permission = "0600"
}
