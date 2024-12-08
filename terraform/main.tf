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

# S3 bucket para publicación de sitio estático
module "static_site" {
  source         = "./modules/s3_static_web"
  environment    = var.environment
  index_document = "index.html"
  error_document = "error.html"

  tags = {
    Environment = var.environment
    Project     = "Obligatorio"
  }
}
resource "aws_vpc" "vpc_obligatorio" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "vpc_obligatorio_${var.environment}"
    Environment = var.environment
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
    description = "Allow Port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 8081"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 8083"
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Port 8085"
    from_port   = 8085
    to_port     = 8085
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

#ECRs 
resource "aws_ecr_repository" "ecr_obligatorio_orders" {
  name = "ecr_orders"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Project = "Obligatorio"
  }
}

resource "aws_ecr_repository" "ecr_obligatorio_shipping" {
  name = "ecr_shipping"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Project = "Obligatorio"
  }
}

resource "aws_ecr_repository" "ecr_obligatorio_payments" {
  name = "ecr_payments"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Project = "Obligatorio"
  }
}

resource "aws_ecr_repository" "ecr_obligatorio_products" {
  name = "ecr_products"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Project = "Obligatorio"
  }
}

# Cluster
resource "aws_eks_cluster" "cluster_obligatorio" {
  name     = "cluster_obligatorio_${var.environment}"
  role_arn = var.role_arn

  vpc_config {
    subnet_ids         = [aws_subnet.subnet_obligatario_public_1.id, aws_subnet.subnet_obligatario_public_2.id]
    security_group_ids = [aws_security_group.security_group_public_obligatario.id]
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_eks_node_group" "node_group_obligatorio" {
  cluster_name    = aws_eks_cluster.cluster_obligatorio.name
  node_group_name = "node_group_obligatorio01"
  node_role_arn   = var.role_arn

  subnet_ids = [aws_subnet.subnet_obligatario_public_1.id, aws_subnet.subnet_obligatario_public_2.id]

  scaling_config {
    desired_size = "10"
    min_size     = "4"
    max_size     = "16"
  }

  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  tags = {
    Environment = var.environment
  }

  depends_on = [
    aws_eks_cluster.cluster_obligatorio
  ]
}
