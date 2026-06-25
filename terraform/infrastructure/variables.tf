variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_pair_name" {
  description = "EC2 Key Pair"
  type        = string
}

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_username" {
  description = "Database Username"
  type        = string
}

variable "db_password" {
  description = "Database Password"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "RDS Instance Class"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS Storage"
  type        = number
}

variable "ssh_port" {
  description = "SSH Port"
  type        = number
}

variable "http_port" {
  description = "HTTP Port"
  type        = number
}

variable "https_port" {
  description = "HTTPS Port"
  type        = number
}

variable "postgres_port" {
  description = "PostgreSQL Port"
  type        = number
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into EC2"
  type        = string
}
