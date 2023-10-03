resource "aws_subnet" "az1-public" {
  vpc_id = aws_vpc.main.id

  availability_zone = var.az1

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 127)

  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 127)


  tags = {
    Name    = "public-az1-tfitilab"
    type    = "public"
    project = var.project_name
    creator = var.creator
  }
}


resource "aws_subnet" "az2-public" {
  vpc_id = aws_vpc.main.id

  availability_zone = var.az2

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 128)

  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 128)

  tags = {
    Name    = "public-az2-tfitilab"
    type    = "public"
    project = var.project_name
    creator = var.creator
  }
}

resource "aws_subnet" "az1-private" {

  vpc_id = aws_vpc.main.id

  availability_zone = var.az1

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)

  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 1)


  tags = {
    Name    = "private-az1-tfitilab"
    type    = "private"
    project = var.project_name
    creator = var.creator
  }
}

resource "aws_subnet" "az2-private" {

  vpc_id = aws_vpc.main.id

  availability_zone = var.az2

  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)

  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)

  tags = {
    Name    = "private-az2-tfitilab"
    type    = "private"
    project = var.project_name
    creator = var.creator
  }
}

