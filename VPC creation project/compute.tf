resource "aws_instance" "ubuntu" {

  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]

  tags = merge(local.comman_tags, {


    Name = "ubuntu_server"



    }
  )


}

resource "aws_security_group" "ubuntu_sg" {

  description = "sg created for allow hthtp and https requests"
  name        = "ubuntu-sg"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.comman_tags, {

    Name = "ubuntu-sg"
    }
  )


}

resource "aws_security_group_rule" "sg_rule_ingress" {
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  security_group_id = aws_security_group.ubuntu_sg.id



}
