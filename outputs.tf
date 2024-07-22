output "default_vpc" {
  value       = data.aws_vpc.default.id
  description = "default vpc"
}

output "private_subnet" {
  value       = aws_subnet.private_subnet.id
  description = "private subnet"
}
