# variable

variable "env" {


  type = string

  validation {


    condition     = var.env == "dev"
    error_message = "bucket is created only for dev environment"

  }

}

# random id for genrate random id

resource "random_id" "dev_bucket_suffix" {



  byte_length = 8


}

# bucket creation

resource "aws_s3_bucket" "dev_bucket_test" {


  bucket = "var.env-${random_id.dev_bucket_suffix.hex}"

  tags = {

    Name = "var.env-${random_id.dev_bucket_suffix.hex}"

  }


}
