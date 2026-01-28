
# key pair
resource "aws_key_pair" "key_pair" {
  key_name   = "bankapp_key"
  public_key = file("bankapp_key.pub")

  tags = {
    Environment = var.aws_env
  }

}

# vpc - default
resource "aws_default_vpc" "default" {

}

# security group
resource "aws_security_group" "security_group" {
  name        = "bankapp_security_group"
  description = "Allow inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name        = "bankapp_security_group"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access for all"
  }
}


# latest ami-id
data "aws_ami" "os_image" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # ubuntu/images/hvm-ssd/*amd64
  }

}

# ec2 instance
resource "aws_instance" "bankapp_instance" {
  ami           = data.aws_ami.os_image.id
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  security_groups = [ aws_security_group.security_group.name ]
  depends_on = [ aws_security_group.security_group, aws_key_pair.key_pair ]

root_block_device {
  volume_size = 30
  volume_type = "gp3"
}
  tags = {
    Name = "Bankapp"
    Environment = var.aws_env
  }
}
