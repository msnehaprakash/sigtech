/* Retrieving default vpc  */
data "aws_vpc" "default" {
  default = true
}

/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.64.0/28"
  tags = {
    Name = var.name
  }
}
/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Name = var.name
  }
}

/* Route table associations */
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

/* Security group for ssh */
resource "aws_security_group" "ssh" {
  name        = "${var.name}-sg"
  description = "Security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
