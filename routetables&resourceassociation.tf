resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {

    cidr_block     = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.main.id

  }


  route {

    ipv6_cidr_block        = "::/0"

    egress_only_gateway_id = aws_egress_only_internet_gateway.main.id

  }

  tags = {
    Name    = "private ${var.project_name}"
    type    = "private"
    project = var.project_name 
    creator = var.creator

  }
}


resource "aws_route_table_association" "az1-private" {

  subnet_id      = aws_subnet.az1-private.id

  route_table_id = aws_route_table.private.id
  
}


resource "aws_route_table_association" "az2-private" {

  subnet_id      = aws_subnet.az2-private.id

  route_table_id = aws_route_table.private.id
}


resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  route {

    ipv6_cidr_block        = "::/0"

    egress_only_gateway_id = aws_egress_only_internet_gateway.main.id

  }

  tags = {
    Name    = "public ${var.project_name}"
    type    = "public"
    project = var.project_name
    creator = var.creator
  }
}


resource "aws_route_table_association" "az1-public" {

  subnet_id      = aws_subnet.az2-public.id
  
  route_table_id = aws_route_table.public.id

}
resource "aws_route_table_association" "az2-public" {

  subnet_id       = aws_subnet.az1-public.id

  route_table_id  = aws_route_table.public.id
  
}