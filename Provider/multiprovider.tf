terraform {

  required_version = "~> 1.7"
  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "~> 5.0"

    }



  }
}

provider "aws" {

  region = "us-east-1"

}

provider "aws" {

  region = "us-east-2"
  alias  = "us-east2"

}

resource "aws_s3_bucket" "us-east-1-bucket" {

  bucket = "mybucket-us-east-1-2025"


}

resource "aws_s3_bucket" "us-east-2-bucket" {

  bucket   = "mybucket-us-east-2-2025"
  provider = aws.us-east2
}
