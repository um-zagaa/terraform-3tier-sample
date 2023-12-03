## Application Load Balancer
resource "aws_lb" "application-load-balancer" {
  name                       = "web-external-load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-aws-security-group.id]
  subnets                    = [aws_subnet.public-web-subnet-1.id, aws_subnet.public-web-subnet-2.id]
  enable_deletion_protection = false

  tags = {
    Name = "Application Load Balancer"
  }
}

resource "aws_lb_target_group" "alb-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-01.id
}

resource "aws_lb_target_group_attachment" "web-attachment" {
  target_group_arn = aws_lb_target_group.alb-target-group.arn
  target_id        = aws_instance.public-web-template.id
  port             = 80
}

resource "aws_lb_target_group" "alb-target-group-middleware" {
  name     = "alb-target-group-middleware"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-01.id
}

resource "aws_lb_target_group_attachment" "web-middleware-attachment" {
  target_group_arn = aws_lb_target_group.alb-target-group-middleware.arn
  target_id        = aws_instance.public-web-template.id
  port             = 3000
}

## Create a listener on port 80 with redirect action
# resource "aws_lb_listener" "alb-http-listener" {
#   load_balancer_arn = aws_lb.application-load-balancer.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = 443
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

## Create a listener on port 433 with forward action to target group
resource "aws_lb_listener" "alb-http-listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = 80
  protocol          = "HTTP"
  # port              = 443
  # protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}

resource "aws_lb_listener" "alb-http-listener-middleware" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = 3000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group-middleware.arn
  }
}