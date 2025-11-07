# Variable

variable "tags_subnet" {

  description = "tags for subnet"
  type        = map(string)

  default = {

    Name       = "publicsubnet"
    managed_by = "terraform"

  }

}


variable "az" {

  description = "az for subnet"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]


}


# data sources
# fetch vpc information
data "aws_vpc" "fetch_vpc_id" {

  filter {

    name   = "tag:Name"
    values = ["default_vpc"]


  }

}

# output variable

output "vpc_id" {

  value = data.aws_vpc.fetch_vpc_id.id

}



output "vpc_cidr_block" {

  value = data.aws_vpc.fetch_vpc_id.cidr_block

}

# resources block
# subnet

resource "aws_subnet" "public_subnet" {

  vpc_id            = data.aws_vpc.fetch_vpc_id.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = var.az[0]


  tags = merge(var.tags_subnet)


}
