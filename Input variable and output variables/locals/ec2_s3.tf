# locals

locals {

  env = "prod"


}


locals {

  common_tags = {

    env = local.env

  }
}



# Resource blocm for Ec2 instance
# input variable
resource "aws_instance" "demo_server" {


  ami           = "ami-0bdd88bd06d16ba03"
  instance_type = "t2.micro"
  key_name      = "terraform"


  tags = merge({

    Name : "shabnam-test"
    name = "gowtham-test"

    },

    local.common_tags
  )

  lifecycle {

    ignore_changes = [tags]

  }
}


# output variable for ec2
output "public_ip" {

  value = aws_instance.demo_server.public_ip

}



# s3 buket creation

resource "random_id" "bucket_suffix" {


  byte_length = 8


}


resource "aws_s3_bucket" "random_bucket" {


  bucket = "test-bucket-${random_id.bucket_suffix.hex}"

  tags = local.common_tags

}

# s3 bucket output variable

output "bucket_name" {

  value = aws_s3_bucket.random_bucket.id

}
