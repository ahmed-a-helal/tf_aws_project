resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name    = "igw tf_iti_lab"
    type    = "public"
    project = var.project_name
    creator = var.creator
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.az1-public.id
  tags = {
    Name    = "Nat gw tf_iti_lab"
    type    = "private"
    project = var.project_name
    creator = var.creator
  }
  depends_on = [aws_internet_gateway.main]
}


resource "aws_egress_only_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "egress gw tf_iti_lab"
    type    = "private"
    project = var.project_name
    creator = var.creator
  }
}
resource "aws_eip" "nat_gateway" {
  vpc = true
}