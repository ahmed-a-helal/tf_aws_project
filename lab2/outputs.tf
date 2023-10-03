output "instances_names" {
    value = aws_instance.instances[*].tags.Name
}

output "public_ips" {
    value = aws_instance.instances[*].public_ip
}

output "private-ips" {
    value = aws_instance.instances[*].private_ip
}