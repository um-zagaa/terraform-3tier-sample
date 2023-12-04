## AWS AMI Amazon linux 2
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

## EC2 instance Presentation Tier
resource "aws_instance" "public-web-template" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.web-server-security-group.id]
  key_name               = "terraform"
  user_data              = file("install-apache.sh")

  tags = {
    Name = "web-instance"
  }
}

## EC2 instance App Tier
resource "aws_instance" "private-app-template" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private-app-subnet-1.id
  vpc_security_group_ids = [aws_security_group.app-server-security-group.id]
  key_name               = "terraform"
  user_data              = file("install-apache.sh")

  tags = {
    Name = "app-instance"
  }
}

## EC2 instance Bastion Host
resource "aws_instance" "bastion-host" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-web-subnet-1.id
  vpc_security_group_ids = [aws_security_group.ssh-security-group.id]
  key_name               = "terraform"

  tags = {
    Name = "bastion-host-instance"
  }
}