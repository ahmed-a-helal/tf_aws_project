resource "aws_subnet" "subnets" {

  count = length(var.availability_zones) * 2

  vpc_id = aws_vpc.main.id

  availability_zone = var.availability_zones[floor(count.index / 2)]

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, var.ipv4_diff_between_vpc_and_subnets_subnetmask, count.index + var.subnetstartcount)

  ipv6_cidr_block = var.enable_ipv6 ? cidrsubnet(aws_vpc.main.ipv6_cidr_block, var.ipv6_diff_between_vpc_and_subnets_subnetmask, count.index + var.subnetstartcount) : null

  assign_ipv6_address_on_creation = var.enable_ipv6

  map_public_ip_on_launch = count.index % 2 == 0 ? true : false

  tags = {
    Name        = count.index % 2 == 0 ? "public_${var.environment}_${var.project_name}" : "private_${var.environment}_${var.project_name}}"
    type        = count.index % 2 == 0 ? "public" : "private"
    environment = var.environment
    project     = var.project_name
    creator     = var.creator
  }
}