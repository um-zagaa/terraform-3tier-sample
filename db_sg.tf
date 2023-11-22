## SG for Database Tier
resource "aws_security_group" "database-security-group" {
    name = "Database Security Group"
    description = "Enable MySQL access on port 3306"
    vpc_id = aws_vpc.vpc-01.id

    ingress {
        description = "MySQL access"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [ "${aws_security_group.web-server-security-group.id}" ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
        Name = "Database Security Group"
    }
}