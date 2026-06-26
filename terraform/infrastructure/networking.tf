#########################################
# NETWORKING
#
# This file provisions the complete
# networking layer for the application.
#
# Resources:
# 1. VPC
# 2. Internet Gateway
# 3. Public Subnet
# 4. Private Subnet
# 5. Public Route Table
# 6. Public Internet Route
# 7. Public Route Table Association
# 8. Private Route Table
# 9. Private Route Table Association
#########################################

#########################################
# VPC
#
# Creates an isolated virtual network
# for all application resources.
#########################################

resource "aws_vpc" "main" {

  cidr_block                           = var.vpc_cidr
  enable_dns_support                   = true
  enable_dns_hostnames                 = true
  enable_network_address_usage_metrics = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc"
    }
  )

}

#########################################
# Internet Gateway
#
# Provides internet connectivity
# for resources in public subnets.
#########################################

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-igw"
    }
  )

}

#########################################
# Public Subnet
#
# Hosts internet-facing resources
# such as the EC2 instance running
# Nginx, Frontend and Backend containers.
#########################################

resource "aws_subnet" "public" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-subnet"
    }
  )

}

#########################################
# Private Subnet
#
# Hosts private resources such as
# the PostgreSQL RDS instance.
#
# Public IP assignment is disabled.
#########################################

resource "aws_subnet" "private" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-subnet"
    }
  )

}

#########################################
# Private Subnet 2
#
# Secondary private subnet used by
# the RDS DB Subnet Group.
#########################################

resource "aws_subnet" "private_2" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_2_cidr
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-subnet-2"
    }
  )

}

#########################################
# Public Route Table
#
# Routing table used by the
# Public Subnet.
#########################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-public-route-table"
    }
  )

}

#########################################
# Public Internet Route
#
# Routes all outbound internet traffic
# (0.0.0.0/0) through the Internet Gateway.
#########################################

resource "aws_route" "public" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id

}

#########################################
# Public Route Table Association
#
# Associates the Public Route Table
# with the Public Subnet.
#########################################

resource "aws_route_table_association" "public_subnet" {

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

}

#########################################
# Private Route Table
#
# Routing table used by the
# Private Subnet.
#
# No internet route is configured.
# Private resources remain isolated.
#########################################

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-private-route-table"
    }
  )

}

#########################################
# Private Route Table Association
#
# Associates the Private Route Table
# with the Private Subnet.
#########################################

resource "aws_route_table_association" "private_subnet" {

  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id

}

#########################################
# Private Route Table Association 2
#
# Associates the second private subnet
# with the Private Route Table.
#########################################

resource "aws_route_table_association" "private_subnet_2" {

  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id

}

#########################################
# Private Route
#
# Intentionally not created.
#
# The Private Subnet has no route to
# the Internet Gateway.
#
# When a NAT Gateway is introduced
# in the future, an Internet route
# will be added here.
#########################################