resource "aws_launch_template" "workernode" {
  name          = "workernode-tf-iti-lab"
  instance_type = "t2.micro"
  image_id      = "ami-01342111f883d5e4e"

  monitoring {
    enabled = true
  }
  network_interfaces {
    ipv6_address_count = 1
    security_groups    = [aws_security_group.worker.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "workernode-tf-iti-lab"
      type    = "worker"
      project = var.project_name
      creator = var.creator
    }
  }

}

resource "aws_launch_template" "bastion" {
  name          = "bastion-tf-iti-lab"
  instance_type = "t2.micro"
  image_id      = "ami-0410d74c821423ce6"
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = true
    ipv6_address_count          = 1
    security_groups             = [aws_security_group.bastion.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "bastion-tf-iti-lab"
      type    = "bastion"
      project = var.project_name
      creator = var.creator
    }
  }

}


resource "aws_instance" "bastion1" {
  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  }
  subnet_id = aws_subnet.az1-public.id
  key_name  = aws_key_pair.sshkey.key_name
  tags = {
    Name    = "bastion-tf-iti-lab"
    type    = "bastion"
    project = var.project_name
    creator = var.creator
  }
  depends_on = [aws_key_pair.sshkey]
}

resource "aws_instance" "bastion2" {
  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  }
  subnet_id = aws_subnet.az2-public.id
  key_name  = aws_key_pair.sshkey.key_name
  tags = {
    Name    = "bastion-tf-iti-lab"
    type    = "bastion"
    project = var.project_name
    creator = var.creator
  }

}

resource "aws_instance" "worker1" {
  launch_template {
    id      = aws_launch_template.workernode.id
    version = "$Latest"
  }
  subnet_id = aws_subnet.az1-private.id
  key_name  = aws_key_pair.sshkey.key_name
  tags = {
    Name    = "workernode1-tf-iti-lab"
    type    = "worker"
    project = var.project_name
    creator = var.creator
  }

}

resource "aws_instance" "worker2" {
  subnet_id = aws_subnet.az2-private.id
  launch_template {
    id      = aws_launch_template.workernode.id
    version = "$Latest"
  }
  key_name = aws_key_pair.sshkey.key_name
  tags = {
    Name    = "workernode2-tf-iti-lab"
    type    = "worker"
    project = var.project_name
    creator = var.creator
  }

}