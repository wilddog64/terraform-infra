variable "environment" {
  description = "a name of an environment, i.e. prod, sandbox, dev, ..."
  type        = string
}

variable "bastion_ami_id" {
  description = "a valid AWS ami id for bringing up bastion host"
  type        = string
}

variable "bastion_instance_type" {
  description = "a valid aws instance type for a bastion host"
  type        = string
}

variable "key_name" {
  description = "an ec2 instance keypair"
  type        = string
}

variable "vpc_public_subnet_cidrblocks" {
  description = "a map of public subnet cidr blocks"
  type        = map(list(string))
}

variable "vpc_private_subnet_cidrblocks" {
  description = "a map of private subnet cidr blocks"
  type        = map(list(string))
}

variable "vpc_cidr_block" {
  description = "a valid cidr block for a vpc"
  type        = string
}
