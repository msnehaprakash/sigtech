output "aws_instance" {
  value       = aws_instance.app_server.id
  description = "ec2 instance"
}
