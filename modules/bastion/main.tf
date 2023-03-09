data "aws_ssm_parameter" "ubuntu-ami" {
  name = "/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}
# Create the bastion host instance
resource "aws_instance" "bastion" {
  # ami           = "ami-0c55b159cbfafe1f0"
  ami = data.aws_ssm_parameter.ubuntu-ami.value
  # instance_type = "t2.micro"
  instance_type               = var.instance_type
  subnet_id                   = var.vpc_public_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  # Install AWS SSM agent
  sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  sudo systemctl enable amazon-ssm-agent
  sudo systemctl start amazon-ssm-agent
  EOF

  tags = {
    Name = "${var.environment}-bastion-host"
  }
}

# Create a security group for the bastion host
resource "aws_security_group" "bastion" {
  name_prefix = "bastion-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-bastion-security-group"
  }
}
