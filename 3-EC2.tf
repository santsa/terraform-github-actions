## Random
resource "random_id" "sg" {
  byte_length = 4
}

## AWS VPC
resource "aws_vpc" "awsec2demo" {
  cidr_block = "172.16.0.0/16"
  
  tags = {
    Name = "vpc-santsa"
  }
}

## AWS VPC Subnet
resource "aws_subnet" "awsec2demo" {
  vpc_id = aws_vpc.awsec2demo.id
  cidr_block = "172.16.10.0/24"
  
  tags = {
    Name = "subnet-santsa"
  }
  
}

## AWS Network Interface
resource "aws_network_interface" "awsec2demo" {
  subnet_id = aws_subnet.awsec2demo.id
  private_ips = ["172.16.10.100"]
  
  tags = {
    Name = "NI-santsa"
  }
}

resource "aws_security_group" "awsec2demo" {
  name = "${random_id.sg.hex}-sg"
  vpc_id = aws_vpc.awsec2demo.id
  
  tags = {
    Name = "sg-santsa"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http_8080" {
  security_group_id = aws_security_group.awsec2demo.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.awsec2demo.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "awsec2demo" {
  ami = "ami-xxxx"
  instance_type = "t2.micro"
  
  network_interface {
    network_interface_id = aws_network_interface.awsec2demo.id
    device_index = 0
  }
}

















