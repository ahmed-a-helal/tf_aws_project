
resource "aws_instance" "instances" {

  count = length(var.instancesPerAZ) * length(var.availability_zones)

  subnet_id = var.instancesPerAZ[count.index % 2].public && module.networking.subnets[0].tags.type == "public" ? module.networking.subnets[2 * floor(count.index / length(var.instancesPerAZ))].id : module.networking.subnets[2 * floor(count.index / length(var.instancesPerAZ)) + 1].id

  key_name = aws_key_pair.sshkey.id

  ami = var.instancesPerAZ[count.index % 2].ami

  instance_type = var.instancesPerAZ[count.index % 2].instance_type

  associate_public_ip_address = var.instancesPerAZ[count.index % 2].public

  ipv6_address_count = var.enable_ipv6 ? 1 : 0

  security_groups = count.index % 2 == 0 ? [aws_security_group.bastion.id] : [aws_security_group.worker.id]

  provisioner "local-exec" {

    command = <<EOT

    [ ${count.index % 2} -eq 0  ] &&\
    echo "The instance ${self.tags.Name} public ip  is ${self.public_ip}"||\
    echo "The instance ${self.tags.Name} private ip  is ${self.private_ip}"
    EOT

  }
  tags = {

    Name = var.instancesPerAZ[count.index % 2].name

    type = var.instancesPerAZ[count.index % 2].type

    project = var.project_name

    environment = var.environment

    creator = var.creator

  }

  depends_on = [aws_key_pair.sshkey]

}
