output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "ssh_private_key_path" {
  value = module.bastion.ssh_private_key_path
}
