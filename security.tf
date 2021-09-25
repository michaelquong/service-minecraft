resource "aws_security_group" "minecraft" {
  name        = "minecraft-sg"
  description = "Allow tcp inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    purpose = "Public access to minecraft on port 25565"
  }
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.minecraft.id
}

resource "aws_security_group_rule" "allow_22" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.admin_ip_addresses
  security_group_id = aws_security_group.minecraft.id
}

resource "aws_security_group_rule" "allow_25565" {
  type              = "ingress"
  from_port         = 25565
  to_port           = 25565
  protocol          = "tcp"
  cidr_blocks       = var.friend_list
  security_group_id = aws_security_group.minecraft.id
}