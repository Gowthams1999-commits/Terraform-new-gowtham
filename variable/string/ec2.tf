## variable blocks


variable "aws_region" {

description = "region for your aws resources"
type = string

}

variable "aws_ami_id" {

  description = "ami id for ec2 instance"
  type        = string


}


variable "aws_instance_type" {

  description = "instance type for ec2"
  type        = string

}

## ec2 instance creation

resource "aws_instance" "demo_server_D" {

  ami           = var.aws_ami_id
  instance_type = var.aws_instance_type

  tags = {

    name = "demo_server_D"

  }
}
