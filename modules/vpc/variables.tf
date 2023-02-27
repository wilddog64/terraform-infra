variable "environment" {
  description = "an environment like prod, stage, sandbox, ..."
  type            = string
}

variable "cidr_block" {
  description = "a vpc cidr block"
  type            = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrblock" {
  description = "a public subnet cidr block"
  type = map(list(string))
  default = {
    "us-west-2a" = [
      "10.0.10.0/24",
      "10.0.20.0/24",
      "10.0.30.0/24",
    ]
  }
}

variable "private_subnet_cidrblock" {
  description = "a private subnet cidr block"
  type = map(list(string))
  default = {
    "us-west-2b" = [
      "10.0.70.0/24",
      "10.0.80.0/24",
      "10.0.90.0/24"
    ]
  }
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
