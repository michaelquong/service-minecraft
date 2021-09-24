resource "aws_instance" "minecraft" {
  name                        = "minecraft-server"
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = tolist(data.aws_subnet_ids.default.ids)[0]
  vpc_security_group_ids      = [security_group.public_sg_25565.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.server.key_name

  user_data = data.template_file.user_data.rendered
}