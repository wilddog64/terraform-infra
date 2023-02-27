# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SETUP NETWORK ACL RULES FOR INBOUND TRAFFIC
# This template attaches rules to an existing network ACL that allow inbound connections on a given set of ports from
# a given set of CIDR blocks. This includes both the inbound rules to allow the inbound connection and the outbound
# rules to allow the response.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE INBOUND RULES
# Allow resources in this subnet to receive requests on the specified ports
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_network_acl" "inbound" {
  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnet_ids

  tags = merge(
    { "Name" = "${var.vpc_name}-public-subnets" },
    var.custom_tags,
  )
}

resource "aws_network_acl_rule" "allow_inbound" {
  for_each = var.public_subnet_set
  network_acl_id = aws_network_acl.inbound.id
  rule_number    = var.ingress_rule_number + (count.index * 5)
  egress         = false
  protocol       = var.protocol
  rule_action    = "allow"
  cidr_block     = each.value
  from_port      = var.inbound_from_port
  to_port        = var.inbound_to_port
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE OUTBOUND RULE FOR RETURN TRAFFIC
# When a resource accepts a connection, it creates a new socket on a different, high numbered ("ephemeral") port to
# send a response. Since network ACLs are stateless, we have to explicitly add these rules that allow "return" traffic.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_network_acl_rule" "allow_outbound_return" {
  for_each = var.public_subnet_set
  network_acl_id = aws_network_acl.inbound.id
  rule_number    = var.egress_rule_number + (count.index * 5)
  egress         = true
  protocol       = var.protocol
  rule_action    = "allow"
  cidr_block     = each.value
  from_port      = var.ephemeral_from_port
  to_port        = var.ephemeral_to_port
}
