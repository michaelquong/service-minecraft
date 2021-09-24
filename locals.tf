# Find Region Default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_od = data.aws_vpc.default.id
}

# Find the latest ubuntu image available
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# Generate Key Pair
resource "tls_private_key" "server" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "server" {
  key_name   = "minecraft-ssh-key"
  public_key = tls_private_key.server.public_key_openssh
}

data "template_file" "user_data" {
  template = file("./user_data/cloud-init.yaml")
}