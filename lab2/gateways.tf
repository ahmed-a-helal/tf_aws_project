
resource "aws_internet_gateway" "main" {
  
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "igw ${var.project_name}"
    type    = "public"
    project = var.project_name
    creator = var.creator
  }

}

resource "aws_egress_only_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "egress gw ${var.project_name}"
    type    = "private"
    project = var.project_name
    creator = var.creator
    environment = var.environment
  }
}

resource "aws_nat_gateway" "main" {

  count = var.enable_natgateway ? 1 : 0

  allocation_id = aws_eip.nat_gateway[0].id

  subnet_id     = aws_subnet.subnets[0].id

  tags = {
    Name    = "Nat_${var.project_name}"
    type    = "private"
    project = var.project_name
    creator = var.creator
    environment = var.environment
  }

  depends_on = [aws_internet_gateway.main]

}
resource "aws_eip" "nat_gateway" {
  count = var.enable_natgateway ? 1 : 0

  domain = "vpc"

}