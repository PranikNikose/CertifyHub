#########################################
# SECURITY GROUPS
#
# This file provisions the security layer
# for the application.
#
# Resources:
# 1. EC2 Security Group
# 2. RDS Security Group
#########################################

#########################################
# EC2 Security Group
#
# Allows inbound traffic from the Internet
# for SSH, HTTP and HTTPS.
#
# Outbound traffic is unrestricted.
#########################################

resource "aws_security_group" "ec2" {

  name        = "${local.name_prefix}-ec2-sg"
  description = "Security Group for EC2 Instance"
  vpc_id      = aws_vpc.main.id

  #########################################
  # SSH
  #########################################

  ingress {

    description = "SSH"

    from_port = var.ssh_port
    to_port   = var.ssh_port

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  #########################################
  # HTTP
  #########################################

  ingress {

    description = "HTTP"

    from_port = var.http_port
    to_port   = var.http_port

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  #########################################
  # HTTPS
  #########################################

  ingress {

    description = "HTTPS"

    from_port = var.https_port
    to_port   = var.https_port

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]

  }

  #########################################
  # Outbound
  #########################################

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2-sg"
    }
  )

}

#########################################
# RDS Security Group
#
# Allows PostgreSQL access only
# from the EC2 Security Group.
#########################################

resource "aws_security_group" "rds" {

  name        = "${local.name_prefix}-rds-sg"
  description = "Security Group for PostgreSQL RDS"
  vpc_id      = aws_vpc.main.id

  #########################################
  # PostgreSQL
  #########################################

  ingress {

    description = "PostgreSQL"

    from_port = var.postgres_port
    to_port   = var.postgres_port

    protocol = "tcp"

    security_groups = [
      aws_security_group.ec2.id
    ]

  }

  #########################################
  # Outbound
  #########################################

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [var.allowed_ssh_cidr]

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-rds-sg"
    }
  )

}