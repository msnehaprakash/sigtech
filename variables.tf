variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "name" {
  description = "Name to be used on resources created like EC2 instance, subnet , route table, etc "
  type        = string
}
