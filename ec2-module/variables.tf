variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}
variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}
variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
}
variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}
variable "vpc_id" {
  description = "The ID of the VPC the subnet group is in."
  type        = string
}
variable "security_groups" {
  description = "List of security group names to associate with."
  type        = list(any)
}
