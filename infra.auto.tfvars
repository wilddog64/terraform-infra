environment           = "sandbox"
bastion_ami_id        = "ami-0d01d792ec4d2b4b4" # CiscoHardended Ubuntu-22.04
bastion_instance_type = "t3.micro"
key_name              = "bastion_key"

vpc_cidr_block = "10.0.0.0/16"
vpc_public_subnet_cidrblocks = {
  "us-west-1b" = [
    "10.0.10.0/24",
    "10.0.20.0/24",
    "10.0.30.0/24",
  ]
}
vpc_private_subnet_cidrblocks = {
  "us-west-1c" = [
    "10.0.70.0/24",
    "10.0.80.0/24",
    "10.0.90.0/24"
  ]
}
