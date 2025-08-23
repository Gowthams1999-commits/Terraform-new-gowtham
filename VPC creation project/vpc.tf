locals {

  comman_tags = {
    Managedby = "terraform"
    Project   = "vpc creation"


  }

}

resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  tags = merge(local.comman_tags, {

    Name = "vpc"

    }
  )
}

resource "aws_internet_gateway" "main_ig" {

  vpc_id = aws_vpc.main.id

  tags = merge(local.comman_tags, {

    Name = "internet-gw"

    }
  )
}

resource "aws_subnet" "public_subnet" {

  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = merge(local.comman_tags, {

    Name = "public_subnet"

    }

  )

}


resource "aws_route_table" "public_routetb" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_ig.id

  }

  tags = merge(local.comman_tags, {

    Name = "route_table"
    }

  )
}


resource "aws_route_table_association" "public_rt_association" {


  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_routetb.id






}
