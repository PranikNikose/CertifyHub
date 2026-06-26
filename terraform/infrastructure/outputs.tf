#########################################
# Database Outputs
#########################################

output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_port" {
  description = "RDS Port"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Database Name"
  value       = aws_db_instance.main.db_name
}

output "db_subnet_group" {
  description = "DB Subnet Group"
  value       = aws_db_subnet_group.main.name
}