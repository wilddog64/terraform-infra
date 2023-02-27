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

variable "inbound_cidr_blocks" {
  description = "A list of CIDR blocks from which inbound connections should be allowed to var.inbound_ports"
  type        = set
}

variable "num_inbound_cidr_blocks" {
  description = "The number of CIDR blocks in var.inbound_cidr_blocks. We should be able to compute this automatically, but due to a Terraform limitation, we can't: https://github.com/hashicorp/terraform/issues/14677#issuecomment-302772685"
  type        = number
}

variable "network_acl_id" {
  description = "The id of the network ACL to which the new rules should be attached"
  type        = string
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
