## Get random number

resource "random_id" "random_s3" {

  byte_length = "6"

}


## Create a bucket
resource "aws_s3_bucket" "static_website_s3" {

  bucket = "static-bucket-${random_id.random_s3.hex}"

  tags = {


    Name = "static_website_s3"

  }
}


## static website configuration
resource "aws_s3_bucket_website_configuration" "static_website_configuration" {

  bucket = aws_s3_bucket.static_website_s3.bucket

  index_document {

    suffix = "index.html"

  }

  error_document {

    key = "error.html"

  }

}

## Disable public access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.static_website_s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

## Upload objects
resource "aws_s3_bucket_object" "s3_index_html" {

  bucket       = aws_s3_bucket.static_website_s3.bucket
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"

}


resource "aws_s3_bucket_object" "s3_error_html" {

  bucket       = aws_s3_bucket.static_website_s3.bucket
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

## Create bucket policy
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.static_website_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website_s3.arn}/*"
      }
    ]
  })
}

## ✅ Outputs must be outside of resources
output "static_website_bucket_name" {
  value = aws_s3_bucket.static_website_s3.bucket
}

output "static_website_url" {
  value = aws_s3_bucket.static_website_s3.website_endpoint
}

root@ip-172-31-29-216:~/terraform/static-website#
root@ip-172-31-29-216:~/terraform/static-website# cat static-bucket.tf
## Get random number

resource "random_id" "random_s3" {

  byte_length = "6"

}


## Create a bucket
resource "aws_s3_bucket" "static_website_s3" {

  bucket = "static-bucket-${random_id.random_s3.hex}"

  tags = {


    Name = "static_website_s3"

  }
}


## static website configuration
resource "aws_s3_bucket_website_configuration" "static_website_configuration" {

  bucket = aws_s3_bucket.static_website_s3.bucket

  index_document {

    suffix = "index.html"

  }

  error_document {

    key = "error.html"

  }

}

## Disable public access
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.static_website_s3.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

## Upload objects
resource "aws_s3_bucket_object" "s3_index_html" {

  bucket       = aws_s3_bucket.static_website_s3.bucket
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"

}


resource "aws_s3_bucket_object" "s3_error_html" {

  bucket       = aws_s3_bucket.static_website_s3.bucket
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

## Create bucket policy
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.static_website_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website_s3.arn}/*"
      }
    ]
  })
}

## ✅ Outputs must be outside of resources
output "static_website_bucket_name" {
  value = aws_s3_bucket.static_website_s3.bucket
}

output "static_website_url" {
  value = aws_s3_bucket.static_website_s3.website_endpoint
}
