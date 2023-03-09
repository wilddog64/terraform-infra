terraform {
  backend "s3" {
    bucket         = "chengkli-terraform"
    key            = "state/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}

provider "aws" {
  region            = "us-west-1"
  use_fips_endpoint = true
}
