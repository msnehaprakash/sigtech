module "ec2_instance" {
  source          = "./ec2-module"
  name            = var.name
  ami             = data.aws_ami.ami.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet.id
  vpc_id          = data.aws_vpc.default.id
  security_groups = [aws_security_group.ssh.id]
}
