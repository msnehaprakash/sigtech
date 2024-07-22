data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"] # Canonical


  filter {
    name   = "name"
    values = ["al2023-ami-*-x*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}
