#########################################
# DATABASE
#
# This file provisions the database layer.
#
# Resources:
# 1. DB Subnet Group
# 2. PostgreSQL RDS Instance
#########################################

#########################################
# DB Subnet Group
#
# Groups the private subnets that can be
# used by the RDS instance.
#########################################

resource "aws_db_subnet_group" "main" {

  name = "${local.name_prefix}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_2.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-db-subnet-group"
    }
  )

}

#########################################
# PostgreSQL RDS Instance
#
# Creates a PostgreSQL database inside
# the private subnets.
#########################################

resource "aws_db_instance" "main" {
  identifier           = "${local.name_prefix}-postgres"
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  allocated_storage    = var.db_allocated_storage
  storage_type         = var.db_storage_type
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]
  publicly_accessible         = var.db_publicly_accessible
  multi_az                    = var.db_multi_az
  backup_retention_period     = var.db_backup_retention_period
  deletion_protection         = var.db_deletion_protection
  skip_final_snapshot         = var.db_skip_final_snapshot
  storage_encrypted           = true
  apply_immediately           = true
  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-postgres"
    }
  )

}