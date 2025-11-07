# locals

locals {

  env        = "production"
  managed_by = "terraform"


}

locals {

  common_tags = {

    maintainer = "gowtham"
    cost       = "cost_yes"

  }
}



# varibel blocks



# sting variable

variable "amiid" {

  description = "ami id for ec2 instance"
  type        = string


}

variable "instance_type" {

  description = "instance type for ec2 instance"
  type        = string
  default     = "t2.micro"

}


variable "key_name" {

  description = "key name for ssh into ec2 instance"
  type        = string
  default     = "terraform.pem"

}

# object block

variable "volume_config" {


  description = "volume type and volume size for ec2"
  type = object({

    delete_on_termination = bool
    volume_type          = string
    volume_size           = number


  })



}
# resource block

resource "aws_instance" "variable_instance" {



  ami           = var.amiid
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = merge({

    Name       = "variable-intance"
    Managed_by = local.managed_by
    Envionment = local.env

    },

    local.common_tags
  )


  root_block_device {


    delete_on_termination = var.volume_config.delete_on_termination
    volume_type           = var.volume_config.volume_type
    volume_size           = var.volume_config.volume_size



  }
}
