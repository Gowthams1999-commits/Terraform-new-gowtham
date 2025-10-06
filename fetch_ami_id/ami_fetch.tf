data "aws_ami" "ubuntu" {
  most_recent = true
  # owners      = ["xxxxxx"]  # Canonical's AWS account ID
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id_info" {

  value = data.aws_ami.ubuntu.id

}
