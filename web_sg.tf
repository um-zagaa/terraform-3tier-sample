## SG for Presentantion Tier
resource "aws_security_group" "web-server-security-group" {
    name = "Presentantion Tier Security Group"
    description = "Enable HTTP/HTTPS access on port 80/443 via ALB and SSH via SSH SG"
    vpc_id = aws_vpc.vpc-01.id

    ingress {
        description = "HTTP access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "${aws_security_group.alb-security-group.id}" ]
    }

    ingress {
        description = "HTTPS access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = [ "${aws_security_group.alb-security-group.id}" ]
    }

    ingress {
        description = "SSH access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "${aws_security_group.alb-security-group.id}" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "Presentantion Tier Security Group"
    }
}