resource "aws_security_group" "bastion" {

  name = "bastion-tf-iti-lab"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "Global SSH"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

    ipv6_cidr_blocks = ["::/0"]

  }

}
resource "aws_security_group" "worker" {

  name = "worker-tf-iti-lab"

  vpc_id = aws_vpc.main.id

  ingress {

    description = "ssh from bastion host only"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    security_groups = [aws_security_group.bastion.id]

  }



  ingress {

    description = "ssh from bastion host only"

    from_port = 3000

    to_port = 3000

    protocol = "tcp"

    cidr_blocks = [aws_vpc.main.cidr_block]

  }
  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

    ipv6_cidr_blocks = ["::/0"]

  }

  depends_on = [aws_security_group.bastion]

}
