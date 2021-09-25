resource "aws_instance" "minecraft" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  availability_zone           = local.instance_availability_zones[0]
  subnet_id                   = tolist(data.aws_subnet_ids.default.ids)[0]
  vpc_security_group_ids      = [aws_security_group.minecraft.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.server.key_name

  user_data = data.template_file.user_data.rendered
}