variable "environment" {
  description = "a name of an environment, i.e. prod, sandbox, dev, ..."
  type = string
}

variable "bastion_ami_id" {
  description = "a valid AWS ami id for bringing up bastion host"
  type = string
}

variable "bastion_instance_type" {
  description = "a valid aws instance type for a bastion host"
  type = string
}

variable "key_name" {
  description = "an ec2 instance keypair"
  type = string
}
