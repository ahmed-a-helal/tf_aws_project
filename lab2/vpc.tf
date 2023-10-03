resource "aws_vpc" "main" {
  cidr_block                       = var.vpc_cidr
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = {
    Name    = "${var.environment}-${var.project_name}"
    project = var.project_name
    creator = var.creator
  }
}

