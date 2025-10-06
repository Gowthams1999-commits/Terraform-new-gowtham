data "aws_vpc" "fetch_vpc" {


  filter {

    name   = "tag:name"
    values = ["demo-vpc-tf"]

  }
}


output "vpc_id" {

  value = data.aws_vpc.fetch_vpc.id
}

resource "aws_subnet" "public-subnet-demo" {


  vpc_id     = data.aws_vpc.fetch_vpc.id
  cidr_block = "10.0.2.0/28"


  tags = {

    name = "public-subnet-demo2"

  }
}

#List subnet name
output "aws-subnet-name" {


value = aws_subnet.public-subnet-demo.id

}
