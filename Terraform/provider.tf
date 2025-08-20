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
}

provider "aws" {

  region = "us-east-1"

}

resource "random_id" "s3_random_id" {

  byte_length = 6

}

resource "aws_s3_bucket" "s3_bucket" {

  bucket = "example-bucket-${random_id.s3_random_id.hex}"

}

output "buket_name" {

  value = aws_s3_bucket.s3_bucket.bucket

}
