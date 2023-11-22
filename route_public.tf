## Route Table
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc-01.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "Public Route Table"
    }
}

## Route table association
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
    subnet_id = aws_subnet.public-web-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-route-table-association" {
    subnet_id = aws_subnet.public-web-subnet-2.id
    route_table_id = aws_route_table.public-route-table.id
}

## Private Subnet application 1
resource "aws_subnet" "private-app-subnet-1" {
    vpc_id = aws_vpc.vpc-01.id
    cidr_block = var.private-app-subnet-1-cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false

    tags = {
        Name = "Private Subnet 1 | App Tier"
    }
}

## Private Subnet application 2
resource "aws_subnet" "private-app-subnet-2" {
    vpc_id = aws_vpc.vpc-01.id
    cidr_block = var.private-app-subnet-2-cidr
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false

    tags = {
        Name = "Private Subnet 2 | App Tier"
    }
}

## Private Subnet database 1
resource "aws_subnet" "private-db-subnet-1" {
    vpc_id = aws_vpc.vpc-01.id
    cidr_block = var.private-db-subnet-1-cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false

    tags = {
        Name = "Private Subnet 1 | DB Tier"
    }
}

## Private Subnet database 2
resource "aws_subnet" "private-db-subnet-2" {
    vpc_id = aws_vpc.vpc-01.id
    cidr_block = var.private-db-subnet-2-cidr
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false

    tags = {
        Name = "Private Subnet 2 | DB Tier"
    }
}