# Create the bastion host instance
resource "aws_instance" "bastion" {
  # ami           = "ami-0c55b159cbfafe1f0"
  ami           = var.ami_id
  # instance_type = "t2.micro"
  instance_type = var.instance_type
  subnet_id     = var.vpc_public_subnet_id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion.id]

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
    cidr_blocks = ["0.0.0.0/0"]
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

# Add a security group rule that allows SSH traffic to the bastion host from your IP address
resource "aws_security_group_rule" "bastion_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = var.cidr_blocks # for accessing bastion from one's workstation
  security_group_id = aws_security_group.bastion.id
}

