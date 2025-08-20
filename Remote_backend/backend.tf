terraform {

  required_version = "~> 1.7"
  required_providers {


    aws = {

      source  = "hashicorp/aws"
      version = "~> 5.0"

    }

    random = {

      source  = "hashicorp/random"
      version = "~> 3.0"

    }


  }


  backend "s3" {

    bucket = "remote-backend-2025"
    key    = "backend/dev/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true

  }


}

provider "aws" {

  region = "us-east-1"

}
