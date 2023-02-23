variable "environment" {
  descdescription = "an environment like prod, stage, sandbox, ..."
  type            = string
}

variable "cidr_block" {
  descdescription = "a vpc cidr block"
  type            = string
  default = "10.0.1.0/16"
}

variable "public_subnet_cidrblock" {
  description = "a public subnet cidr block"
  type            = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidrblock" {
  description = "a private subnet cidr block"
  type            = string
  default = "10.0.2.0/24"
}

variable "public_subnet_az" {
  description = "an availability zone for public subnet" 
  type = string
  default = "us-west-2a"
}

variable "private_subnet_az" {
  description = "an availability zone for private subnet" 
  type = string
  default = "us-west-2b"
}
