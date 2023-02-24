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
  vpc_public_subnet_id = module.vpc.public_subnet_id[0]
  cidr_blocks = [
    "216.9.31.182/32"
  ]
}
