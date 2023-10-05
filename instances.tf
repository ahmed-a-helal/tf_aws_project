resource "aws_instance" "bastion1" {

  # Red Hat Linux AMI
  ami = "ami-026ebd4cfe2c043b2"

  instance_type = "t2.micro"

  subnet_id = aws_subnet.az1-public.id

  key_name = aws_key_pair.sshkey.key_name

  associate_public_ip_address = true

  security_groups = [aws_security_group.bastion.id]

  ipv6_address_count = 1

  tags = {
    Name    = "bastion-tf-iti-lab"
    type    = "bastion"
    project = var.project_name
    creator = var.creator
  }

  depends_on = [aws_key_pair.sshkey, aws_security_group.bastion]
}




resource "aws_instance" "bastion2" {

  # Red Hat Linux AMI
  ami = "ami-026ebd4cfe2c043b2"

  instance_type = "t2.micro"

  subnet_id = aws_subnet.az2-public.id

  key_name = aws_key_pair.sshkey.key_name

  associate_public_ip_address = true

  security_groups = [aws_security_group.bastion.id]

  ipv6_address_count = 1

  tags = {
    Name    = "bastion-tf-iti-lab"
    type    = "bastion"
    project = var.project_name
    creator = var.creator
  }
  depends_on = [aws_key_pair.sshkey, aws_security_group.bastion]
}




resource "aws_instance" "worker1" {

  # Amazon Linux Image
  ami = "ami-03a6eaae9938c858c"

  instance_type = "t2.micro"

  subnet_id = aws_subnet.az1-private.id

  key_name = aws_key_pair.sshkey.key_name

  associate_public_ip_address = false

  security_groups = [aws_security_group.worker.id]

  ipv6_address_count = 1

  tags = {
    Name    = "workernode1-tf-iti-lab"
    type    = "worker"
    project = var.project_name
    creator = var.creator
  }

  depends_on = [aws_key_pair.sshkey, aws_security_group.worker]
}




resource "aws_instance" "worker2" {

  # Amazon Linux Image
  ami = "ami-03a6eaae9938c858c"

  instance_type = "t2.micro"

  subnet_id = aws_subnet.az2-private.id

  associate_public_ip_address = false

  key_name = aws_key_pair.sshkey.key_name

  security_groups = [aws_security_group.worker.id]

  ipv6_address_count = 1

  tags = {
    Name = "workernode2-tf-iti-lab"

    type = "worker"

    project = var.project_name

    creator = var.creator
  }
  depends_on = [aws_key_pair.sshkey, aws_security_group.worker]
}