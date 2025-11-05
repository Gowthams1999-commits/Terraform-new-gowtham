# Resource blocm for Ec2 instance

# input variable
resource "aws_instance" "demo_server" {


  ami           = "ami-0bdd88bd06d16ba03"
  instance_type = "t2.micro"
  key_name      = "terraform"


  tags = {

    Name : "shabnam-test"
    name = "gowtham-test"

  }

  lifecycle {

    ignore_changes = [tags]

  }
}

# output variable
output "public_ip" {

value = aws_instance.demo_server.public_ip

}
