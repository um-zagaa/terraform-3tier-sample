## Auto Scaling Group (ASG) for Presentation Tier
resource "aws_launch_template" "auto-scaling-group-web" {
  name_prefix   = "auto-scaling-group-web"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  user_data     = file("install-apache.sh")
  key_name      = "source_key"

  network_interfaces {
    subnet_id       = aws_subnet.public-web-subnet-1.id
    security_groups = [aws_security_group.web-server-security-group.id]
  }
}

resource "aws_autoscaling_group" "auto-scaling-group-1" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group-web.id
    version = "$Latest"
  }
}

## ASG for Application Tier
resource "aws_launch_template" "auto-scaling-group-app" {
  name_prefix   = "auto-scaling-group-app"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = "source_key"

  network_interfaces {
    subnet_id       = aws_subnet.private-app-subnet-1.id
    security_groups = [aws_security_group.ssh-security-group.id]
  }
}

resource "aws_autoscaling_group" "auto-scaling-group-2" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group-app.id
    version = "$Latest"
  }
}
