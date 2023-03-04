# ----------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These variables are expected to be passed in by the operator when calling this terraform module.
# ----------------------------------------------------------------------------------------------------------------------

variable "inbound_from_port" {
  description = "Allow all inbound traffic on ports between var.inbound_from_port and var.inbound_to_port, inclusive"
  type        = number
}

variable "inbound_to_port" {
  description = "Allow all inbound traffic on ports between var.inbound_from_port and var.inbound_to_port, inclusive"
  type        = number
}

variable "ingress_rule_number" {
  description = "The starting number to use for ingress rules that are added. Each ingress rule in an network ACL must have a unique rule number."
  type        = number
}

variable "egress_rule_number" {
  description = "The number to use for the egress rule that will be added. Each egress rule in an network ACL must have a unique rule number."
  type        = number
}

variable "protocol" {
  description = "The protocol (e.g. TCP). If you set this value to -1 or 'all', any protocol and any port is allowed (so the from_port and to_port settings are ignored!)."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# DEFINE CONSTANTS
# Generally, these values won't need to be changed.
# ---------------------------------------------------------------------------------------------------------------------

# See http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html#VPC_ACLs_Ephemeral_Ports
variable "ephemeral_from_port" {
  description = "Return traffic will be allowed on all ports between var.ephemeral_from_port and var.ephemeral_to_port, inclusive, from var.inbound_cidr_blocks"
  type        = number
  default     = 1024
}

# See http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_ACLs.html#VPC_ACLs_Ephemeral_Ports
variable "ephemeral_to_port" {
  description = "Return traffic will be allowed on all ports between var.ephemeral_from_port and var.ephemeral_to_port, inclusive, from var.inbound_cidr_blocks"
  type        = number
  default     = 65535
}

variable "vpc_name" {
  description = "a name of this vpc. mainly used for tagging the vpc resource"
  type        = string
}

variable "vpc_id" {
  description = "a vpc id"
  type        = string
}

variable "public_subnet_ids" {
  description = "a list of pubic subnet ids"
  type        = list(string)
}

variable "public_subnet_cidr_blocks" {
  description = "a list of public subnet cidr blocks"
  type        = map(string)
}

variable "custom_tags" {
  description = "a dictionary of user prvided tags"
  type        = map(string)
  default     = {}
}
