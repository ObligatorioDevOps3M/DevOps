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

resource "aws_vpc" "vpc_obligatorio" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc_obligatorio"
  }
}

resource "aws_subnet" "subnet_obligatario_public_1" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet_obligatario_public_1"
  }
}

resource "aws_subnet" "subnet_obligatario_public_2" {
  vpc_id                  = aws_vpc.vpc_obligatorio.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet_obligatario_public_2"
  }
}

resource "aws_internet_gateway" "igw_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id

  tags = {
    "Name" = "igw_obligatorio"
  }
}

resource "aws_route_table" "route_table_vpc_obligatorio" {
  vpc_id = aws_vpc.vpc_obligatorio.id
}

resource "aws_route" "route_public_vpc_obligatorio" {
  route_table_id         = aws_route_table.route_table_vpc_obligatorio.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_obligatorio.id
}

resource "aws_route_table_association" "vpc_public_route_table_associate_1" {
  route_table_id = aws_route_table.route_table_vpc_obligatorio.id
  subnet_id      = aws_subnet.subnet_obligatario_public_1.id
}

resource "aws_route_table_association" "vpc_public_route_table_associate_2" {
  route_table_id = aws_route_table.route_table_vpc_obligatorio.id
  subnet_id      = aws_subnet.subnet_obligatario_public_2.id
}

resource "aws_security_group" "security_group_public_obligatario" {
  name        = "security_group_public_obligatario"
  vpc_id      = aws_vpc.vpc_obligatorio.id
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
    "Name" = "security_group_public_obligatario"
  }

}

resource "aws_eks_cluster" "cluster_obligatorio" {
  name     = "cluster_obligatorio"
  role_arn = "arn:aws:iam::140598534703:role/LabRole" #TODO: Hacer variable

  vpc_config {
    subnet_ids         = [aws_subnet.subnet_obligatario_public_1.id,aws_subnet.subnet_obligatario_public_2.id]
    security_group_ids = [aws_security_group.security_group_public_obligatario.id]
  }

  tags = {
    Environment = "develop" #TODO: Hacer variable.
  }
}

resource "aws_eks_node_group" "node_group_obligatorio" {
  cluster_name    = "cluster_obligatorio"
  node_group_name = "node_group_obligatorio01"
  node_role_arn   = "arn:aws:iam::140598534703:role/LabRole" #TODO: Hacer variable

  subnet_ids = [aws_subnet.subnet_obligatario_public_1.id]

  scaling_config {
    desired_size = "2"
    min_size     = "2"
    max_size     = "3"
  }

  instance_types = ["t2.micro"] #TODO: Hacer variable
  capacity_type  = "SPOT"

  tags = {
    Environment = "develop" #TODO:Hacer variable
  }

  depends_on = [
    aws_eks_cluster.cluster_obligatorio
  ]
}
