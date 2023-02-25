output "public_ip" {
  value = aws_instance.bastion.public_ip
}

output "ssh_private_key_path" {
  value = local.ssm_ssh_private_key_path
}
