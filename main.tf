module "vpc" {
  source = "./modules/vpc/"  
  environment = var.environment
}
