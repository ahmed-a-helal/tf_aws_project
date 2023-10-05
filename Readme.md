# terraform AWS infrastructure (lab2)

This branch is a conitinuation of the previous branch (lab1)

-----

## main Feature
 
 - modularized the network part (subnets - vpc - routetable - gateways ) into networking modules 
   - support of creating 1 private subnet and 1 public subnet per availability zone
   - support of enabling/disabling NAT 
   - support of enabling/disabling ipv6 and ipv6-egress-only gateway support 
 - auto generation of  public and private key pair
 - ec2 instances generation per Availability zone accourding to the "public" flag that will determine its subnet allocation.
 - pipeline support using Jenkins with: 
   - aws credentials plugin 
   - docker-plugin
 - remote state file on s3 bucket 
   - A lambda function triggerring SES notification  Email