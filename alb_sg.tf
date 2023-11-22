## SG for Application Load Balancer
resource "aws_security_group" "alb-aws-security-group" {
    name = "ALB Security Group"
    description = "Enable HTTP/HTTPS access on port 80/443"
    vpc_id = aws_vpc.vpc-01.id

    ingress {
        description = "HTTP access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        description = "HTTPS access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "ALB Security Group"
    }
}