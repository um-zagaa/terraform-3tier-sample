## NAT Gateway
resource "aws_eip" "eip-nat" {
    domain  = "vpc"

    tags = {
        Name = "eip1"
    }
}

resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.eip-nat.id
    subnet_id = aws_subnet.public-web-subnet-2.id

    tags = {
        Name = "nat1"
    }
}