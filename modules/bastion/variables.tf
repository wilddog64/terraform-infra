variable "ami_id" {
  description = "a valid ami id from AWS"
  type = string
}

variable "instance_type" {
  description = "a valid AWS instance type"
  type = string
}

variable "vpc_public_subnet_id" {
  description = "a public subnet id where this instance will be for a given vpc"
  type = string
}

variable "environment" {
  description = "a tag for which enviornment this is. For example, sandbox"
  type = string
}

variable "cidr_blocks" {
  description = "a list of cidr blocks that can allow ssh traffic"
  type = list(string)
}

variable "vpc_id" {
  description = "a valid aws vpc id"
  type = string
}

variable "key_name" {
  description = "an ec2 ssh key name"
  type = string
}
