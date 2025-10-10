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



## Objects

variable "volume_config" {

  description = ""
  type = object({

    volume_size           = number
    volume_type           = string
    delete_on_termination = bool



  })

}

## ec2 instance creation

resource "aws_instance" "demo_server_D" {

  ami           = var.aws_ami_id
  instance_type = var.aws_instance_type

  tags = {

    name = "demo_server_D"

  }



  root_block_device {

    delete_on_termination = var.volume_config.delete_on_termination
    volume_size           = var.volume_config.volume_size
    volume_type           = var.volume_config.volume_type


  }

}
