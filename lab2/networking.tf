module "networking" {
  source = "./networking"

  creator = var.creator

  project_name = var.project_name

  environment = var.environment

  region = var.region

  vpc_cidr = var.vpc_cidr

  ipv4_diff_between_vpc_and_subnets_subnetmask = var.ipv4_diff_between_vpc_and_subnets_subnetmask
  ipv6_diff_between_vpc_and_subnets_subnetmask = var.ipv6_diff_between_vpc_and_subnets_subnetmask

  enable_ipv6 = var.enable_ipv6

  enable_natgateway = var.enable_natgateway

  availability_zones = var.availability_zones

  subnetstartcount = var.subnetstartcount
}