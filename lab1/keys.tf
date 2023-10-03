resource "tls_private_key" "sshkey" {
  
  algorithm = "RSA"

  rsa_bits  = 4096

}
resource "aws_key_pair" "sshkey" {
  
  key_name   = var.project_name

  public_key = tls_private_key.sshkey.public_key_openssh

  provisioner "local-exec" {

    command = <<EOT
    
    echo "${tls_private_key.sshkey.private_key_pem}" > "./${var.project_name}.pem"
    
    # changing permissions to use it in the ssh commands
    chmod 400 "./${var.project_name}.pem"
    
    EOT
  
  }

}

