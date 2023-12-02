## SG for Application Load Balancer
resource "aws_security_group" "alb-aws-security-group" {
  name        = "ALB Security Group"
  description = "Enable HTTP/HTTPS access on port 80/443"
  vpc_id      = aws_vpc.vpc-01.id

  # Allow incoming HTTP from All IP
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow incoming HTTPS from All IP
  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing all to internet group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB Security Group"
  }
}

## SG for SSH (Bastion Host)
resource "aws_security_group" "ssh-security-group" {
  name        = "SSH Access"
  description = "Enable SSH access on port 22"
  vpc_id      = aws_vpc.vpc-01.id

  # Allow incoming SSH from your IP
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh-locate}"]
  }

  # Allow outgoing MySQL to DB security group
  # egress {
  #   from_port       = 3306
  #   to_port         = 3306
  #   protocol        = "tcp"
  #   security_groups = ["${aws_security_group.database-security-group}"]
  # }

  # Allow outgoing all to internet group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH Security Group"
  }
}

## SG for Presentantion Tier
resource "aws_security_group" "web-server-security-group" {
  name        = "Presentantion Tier Security Group"
  description = "Enable HTTP/HTTPS access on port 80/443 via ALB and SSH via SSH SG"
  vpc_id      = aws_vpc.vpc-01.id

  # Allow incoming HTTP from ALB SG
  ingress {
    description     = "HTTP access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-aws-security-group.id}"]
  }

  # Allow incoming HTTPS from ALB SG
  ingress {
    description     = "HTTPS access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-aws-security-group.id}"]
  }

  # Allow incoming SSH from Bastion Host
  ingress {
    description     = "SSH access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh-security-group.id}"]
  }

  # Allow outgoing all to internet group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Presentantion Tier Security Group"
  }
}

## SG for Application Tier
resource "aws_security_group" "app-server-security-group" {
  description = "Enable HTTP/HTTPS access on port 80/443 via Presentantion Tier and SSH via SSH SG"
  vpc_id      = aws_vpc.vpc-01.id

  # Allow incoming HTTP from Presentantion Tier SG
  ingress {
    description     = "HTTP access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web-server-security-group.id}"]
  }

  # Allow incoming HTTPS from Presentantion Tier SG
  ingress {
    description     = "HTTPS access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web-server-security-group.id}"]
  }

  # Allow incoming SSH from Bastion Host
  ingress {
    description     = "SSH access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh-security-group.id}"]
  }

  # Allow outgoing MySQL to DB security group
  # egress {
  #   from_port       = 3306
  #   to_port         = 3306
  #   protocol        = "tcp"
  #   security_groups = ["${aws_security_group.database-security-group}"]
  # }

  # Allow outgoing all to internet group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Application Tier Security Group"
  }
}

## SG for Database Tier
resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "Enable MySQL access on port 3306 via Application Tier"
  vpc_id      = aws_vpc.vpc-01.id

  # Allow incoming MySQL from Application Tier SG and Bastion Host
  ingress {
    description     = "MySQL access"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.app-server-security-group.id}", "${aws_security_group.ssh-security-group.id}"]
  }

  # Allow outgoing all to internet group
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database Security Group"
  }
}