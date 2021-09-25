# Find Region Default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_availability_zones" "all" {}

data "aws_ec2_instance_type_offering" "discover" {
  for_each = toset(data.aws_availability_zones.all.names)

  filter {
    name   = "instance-type"
    values = [var.instance_type]
  }

  filter {
    name   = "location"
    values = [each.value]
  }

  location_type = "availability-zone"

  preferred_instance_types = [var.instance_type]
}

locals {
  instance_availability_zones = keys({ for az, details in data.aws_ec2_instance_type_offering.discover : az => details.instance_type })
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