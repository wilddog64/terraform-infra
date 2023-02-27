module "vpc" {
  source = "./modules/vpc/"  
  environment = var.environment
}

module "bastion" {
  source = "./modules/bastion/"
  environment = var.environment
  ami_id = var.bastion_ami_id
  vpc_id = module.vpc.id
  key_name = var.key_name
  instance_type = var.bastion_instance_type
  vpc_public_subnet_id = module.vpc.public_subnet_ids[0]
  cidr_blocks = [
    "216.9.31.182/32"
  ]
}


module "ssh-inbound-acl" {
  source = "./modules/inbound-network-acl/"

  vpc_id = module.vpc.id
  vpc_name = "${var.environment}-${module.vpc.id}"
  public_subnet_ids = module.vpc.public_subnet_ids
  public_subnet_cidr_blocks = module.vpc.public_subnet_cidrs_blocks
  ingress_rule_number = 100
  egress_rule_number = 100
  protocol = "tcp"
  inbound_from_port = 22
  inbound_to_port = 22
}

