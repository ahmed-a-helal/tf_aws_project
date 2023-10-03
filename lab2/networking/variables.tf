variable "environment" {
  type    = string
  default = "main"
}
variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list
}

variable "region" {
  type = string
}
variable "project_name" {
  type = string
}

variable "creator" {
  type = string
}

variable "ipv4_diff_between_vpc_and_subnets_subnetmask" {
  type    = number
  default = 4
}

variable "ipv6_diff_between_vpc_and_subnets_subnetmask" {
  type    = number
  default = 4
}
variable "enable_ipv6" {
  type    = bool
  default = false
}
variable "subnetstartcount" {
  type    = number
  default = 1
}

variable "enable_natgateway" {
  type    = bool
  default = false
}
