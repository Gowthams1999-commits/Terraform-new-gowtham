## variable blocks


variable "aws_region" {

  description = "region for your aws resources"
  type        = string

}

variable "aws_ami_id" {

  description = "ami id for ec2 instance"
  type        = string


}


# validation block
variable "aws_instance_type" {

  description = "instance type for ec2"
  type        = string

  validation {

    condition     = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t2.large"
    error_message = "only support for instance type t2.micro and t2.large"

  }

}

##Numbers

variable "root_volume_size" {

  description = "provide volume size"
  type        = number


}

## ec2 instance creation

resource "aws_instance" "demo_server_D" {

  ami           = var.aws_ami_id
  instance_type = var.aws_instance_type

  tags = {

    name = "demo_server_D"

  }



  root_block_device {

    delete_on_termination = true
    volume_size           = var.root_volume_size
    volume_type           = "gp3"


  }

}
