creator = "Ahmed Attia"

project_name = "tf-iti-lab"

environment = "production"

region = "us-east-1"

vpc_cidr = "10.34.0.0/16"

# bit number for example if the cpv cidr is 10.34.0.0/16 then the subnet cidr is 10.34.0.0/24
ipv4_diff_between_vpc_and_subnets_subnetmask = 8
ipv6_diff_between_vpc_and_subnets_subnetmask = 8

enable_ipv6 = false

enable_natgateway = true

availability_zones = ["us-east-1a", "us-east-1b"]

subnetstartcount = 10

instancesPerAZ = [
  {
    ami           = "ami-026ebd4cfe2c043b2"
    name          = "Bastion"
    type          = "bastion"
    instance_type = "t2.micro"
    ipv6          = true
    public        = true
    }, {
    ami           = "ami-03a6eaae9938c858c"
    name          = "Worker"
    type          = "worker"
    instance_type = "t2.micro"
    ipv6          = true
    public        = false
  }
]




