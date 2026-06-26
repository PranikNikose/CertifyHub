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

variable "private_subnet_2_cidr" {
  description = "Private Subnet 2 CIDR"
  type        = string
}

variable "availability_zone_2" {
  description = "Secondary Availability Zone"
  type        = string
}

#DB 
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

variable "db_engine" {
  description = "Database Engine"
  type        = string
}

variable "db_engine_version" {
  description = "Database Engine Version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS Instance Class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated Storage (GB)"
  type        = number
}

variable "db_storage_type" {
  description = "Storage Type"
  type        = string
}

variable "db_backup_retention_period" {
  description = "Backup Retention Days"
  type        = number
}

variable "db_skip_final_snapshot" {
  description = "Skip Final Snapshot"
  type        = bool
}

variable "db_deletion_protection" {
  description = "Deletion Protection"
  type        = bool
}

variable "db_publicly_accessible" {
  description = "Public Accessibility"
  type        = bool
}

variable "db_multi_az" {
  description = "Multi AZ"
  type        = bool
}

#EC2
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "key_pair_name" {
  description = "AWS Key Pair Name"
  type        = string
}

variable "root_volume_size" {
  description = "Root Volume Size"
  type        = number
}

variable "root_volume_type" {
  description = "Root Volume Type"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH Public Key"
  type        = string
}