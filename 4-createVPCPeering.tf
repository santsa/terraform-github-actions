## Create VPC-1
resource "aws_vpc" "useastvpcsantsa" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "VPC-1"
  }
}

## Create VPC-2
resource "aws_vpc" "uswestvpcsantsa" {
  provider   = aws.central
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "VPC-2"
  }
}

## Create Peering between VPC-1 and VPC-2
resource "aws_vpc_peering_connection" "vpcpeerigdemo" {
  peer_owner_id = var.target_aws_account_id
  peer_vpc_id   = aws_vpc.uswestvpcsantsa.id
  vpc_id        = aws_vpc.useastvpcsantsa.id
  peer_region   = "us-west-1"
  auto_accept   = false

  tags = {
    Name = "VPC1-to-VPC2"
  }
}

#Accepter's side of the peering connection
resource "aws_vpc_peering_connection_accepter" "vpcpeerigdemoaccept" {
  provider                  = aws.central
  vpc_peering_connection_id = aws_vpc_peering_connection.vpcpeerigdemo.id
  auto_accept               = true

  tags = {
    Name = "VPC2-to-VPC1"
  }
} 
