creator = "Ahmed Attia"

project_name = "tf-iti-lab"

environment = "devel"

region = "eu-central-1"

vpc_cidr = "10.34.0.0/16"

# bit number for example if the cpv cidr is 10.34.0.0/16 then the subnet cidr is 10.34.0.0/24
ipv4_diff_between_vpc_and_subnets_subnetmask = 8
ipv6_diff_between_vpc_and_subnets_subnetmask = 8

enable_ipv6 = false

enable_natgateway = true

availability_zones = ["eu-central-1a", "eu-central-1b"]

subnetstartcount = 10

instancesPerAZ = [
  {
    ami           = "ami-088e71edb8795252f"
    name          = "Bastion"
    type          = "bastion"
    instance_type = "t2.micro"
    ipv6          = true
    public        = true
    }, {
    ami           = "ami-088e71edb8795252f"
    name          = "Worker"
    type          = "worker"
    instance_type = "t2.micro"
    ipv6          = true
    public        = false
  }
]




