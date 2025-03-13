terraform {
#   required_version = ">= 1.7.5, < 1.9.6"

  backend "s3" {
    encrypt = true
    bucket = "test-state-terrass-projs"
    region = "us-east-2"
    key = "terraform/state/terraform.tfstate"
    # profile = "test-dev"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
