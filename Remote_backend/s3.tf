resource "aws_s3_bucket" "remote_backend" {

  bucket = "remote-backend-2025"

}

output "s3-bucket-name" {

  value = aws_s3_bucket.remote_backend.bucket

}
