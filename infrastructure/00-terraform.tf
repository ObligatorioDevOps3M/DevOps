terraform {
  required_version = ">= 0.14.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_vpc" "vpc-obligatario" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc-obligatario"
  }
}

resource "aws_subnet" "subnet-obligatario-public-1" {
  vpc_id                  = aws_vpc.vpc-obligatario.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet-obligatario-public-1"
  }
}

resource "aws_internet_gateway" "igw-obligatorio" {
  vpc_id = aws_vpc.vpc-obligatario.id

  tags = {
    "Name" = "igw-obligatorio"
  }
}

resource "aws_route_table" "route-table-vpc-obligatario" {
  vpc_id = aws_vpc.vpc-obligatario.id
}

resource "aws_route" "route-public-vpc-obligatario" {
  route_table_id         = aws_route_table.route-table-vpc-obligatario.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw-obligatorio.id
}

resource "aws_route_table_association" "vpc-dev-public-route-table-associate" {
  route_table_id = aws_route_table.route-table-vpc-obligatario.id
  subnet_id      = aws_subnet.subnet-obligatario-public-1.id
}

resource "aws_security_group" "security-group-public-obligatario" {
  name        = "security-group-public-obligatario"
  vpc_id      = aws_vpc.vpc-obligatario.id
  description = "Default Security Group for Public Obligatorio"

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "security-group-public-obligatario"
  }

}
