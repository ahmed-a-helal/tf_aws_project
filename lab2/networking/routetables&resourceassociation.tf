resource "aws_route_table" "routetables" {
  count  = 2
  vpc_id = aws_vpc.main.id
  dynamic "route" {


    # disable this route if the nat is disabled in case of private route table
    for_each = count.index != 1 || var.enable_natgateway ? [true] : []
    content {
      cidr_block = "0.0.0.0/0"

      gateway_id = count.index == 0 ? aws_internet_gateway.main.id : null

      nat_gateway_id = count.index == 0 ? null : aws_nat_gateway.main[0].id
    }

  }
  dynamic "route" {
    for_each = var.enable_ipv6 ? [true] : []
    content {
      ipv6_cidr_block        = "::/0"
      egress_only_gateway_id = aws_egress_only_internet_gateway.main.id
    }
  }

  tags = {
    Name        = count.index == 0 ? "public-${var.environment}-${var.project_name}" : "private-${var.environment}-${var.project_name}"
    type        = count.index == 0 ? "public" : "private"
    environment = var.environment
    project     = var.project_name
    creator     = var.creator

  }
}
resource "aws_route_table_association" "routetables" {
  count = length(aws_subnet.subnets)

  subnet_id = aws_subnet.subnets[count.index].id

  route_table_id = aws_route_table.routetables[count.index % 2].id

}