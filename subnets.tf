## Public Subnet- 1
resource "aws_subnet" "public-web-subnet-1" {
    vpc_id = aws_vpc.vpc-01.id
    cidr_block = var.public-web-subnet-1-cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public Subnet 1"
    }
}

## Public Subnet- 2
resource "aws_subnet" "public-web-subnet-2" {
    vpc_id = aws_vpc.vpc-01.id
    cidr_block = var.public-web-subnet-2-cidr
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public Subnet 2"
    }
}