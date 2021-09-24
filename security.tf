resource "aws_security_group" "public_sg_25565" {
  name        = "minecraft-security-group"
  description = "Allow tcp inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress = [
    {
      description = "Minecraft port"
      from_port   = 25565
      to_port     = 25565
      protocol    = "tcp"
      cidr_blocks = [data.aws_vpc.default.cidr_block]
    }
  ]

  egress = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    purpose = "Public access to minecraft on port 25565"
  }
}