terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
  backend "remote" {}
}

provider "aws" {
  region = var.region
}