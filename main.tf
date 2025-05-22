module "vpc" {
  source     = "./modules/VPC"
  cidr_block = "10.0.0.0/24"
}

module "ig" {
  source = "./modules/INTERNET_GATEWAY"
  vpc_id = module.vpc.vpc_id
}

module "subnet" {
  source     = "./modules/PUBLIC_SUBNET"
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.0.0/28"
}

module "route_table" {
  source              = "./modules/ROUTE_TABLE"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.ig.internet_gateway_id
  subnet_id           = module.subnet.subnet_id
}

module "sg" {
  source = "./modules/SECURITY_GROUP"
  vpc_id = module.vpc.vpc_id
  name   = "ec2-sg"
}

module "key_pair" {
  source = "./modules/KEY_PAIR"
}

module "ec2" {
  source                 = "./modules/EC2"
  instance_type          = "t2.micro"
  subnet_id              = module.subnet.subnet_id
  vpc_security_group_ids = [module.sg.security_group_id]
  key_name               = module.key_pair.key_name
  user_data              = <<-EOF
                #!/bin/bash
                apt update
                apt install -y nginx
                systemctl start nginx
                systemctl enable nginx
                echo "Hello from Terraform EC2" > /var/www/html/index.html
              EOF
}
