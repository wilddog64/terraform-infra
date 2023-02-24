resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "aws_key_pair" "public_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_ssm_parameter" "ssh_private_key" {
  description = "a terraform managed ssh private key"
  name        = local.ssm_ssh_private_key_path
  type        = "SecureString"
  value       = tls_private_key.ssh.private_key_pem
  overwrite   = true
}
