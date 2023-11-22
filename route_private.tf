## Route Table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc-01.id

   route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat-gateway.id
    }

    tags = {
        Name = "Private Route Table"
    }
}

## Route table association for App Tier
resource "aws_route_table_association" "private-subnet-app-1-nat-route-table-association" {
    subnet_id = aws_subnet.private-app-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-subnet-app-2-nat-route-table-association" {
    subnet_id = aws_subnet.private-app-subnet-2.id
    route_table_id = aws_route_table.public-route-table.id
}

## Route table association for DB Tier
resource "aws_route_table_association" "private-subnet-db-1-nat-route-table-association" {
    subnet_id = aws_subnet.private-db-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-subnet-db-2-nat-route-table-association" {
    subnet_id = aws_subnet.private-db-subnet-2.id
    route_table_id = aws_route_table.public-route-table.id
}