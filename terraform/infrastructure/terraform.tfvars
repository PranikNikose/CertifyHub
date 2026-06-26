project_name = "certifyhub"
environment  = "dev"

aws_region = "ap-south-1"

vpc_cidr              = "10.0.0.0/16"
public_subnet_cidr    = "10.0.1.0/24"
private_subnet_cidr   = "10.0.2.0/24"
private_subnet_2_cidr = "10.0.3.0/24"

availability_zone   = "ap-south-1a"
availability_zone_2 = "ap-south-1b"

ec2_instance_type = "t2.micro"

ssh_port      = 22
http_port     = 80
https_port    = 443
postgres_port = 5432

allowed_ssh_cidr = "0.0.0.0/0" #YOUR_PUBLIC_IP/32


#DB 
db_name     = "certifyhub"
db_username = "certifyhub"
db_password = "certifyhub"

db_engine         = "postgres"
db_engine_version = "15"

db_instance_class = "db.t3.micro"

db_allocated_storage = 20
db_storage_type      = "gp3"

db_backup_retention_period = 1

db_skip_final_snapshot = true
db_deletion_protection = false
db_publicly_accessible = false
db_multi_az            = false



#EC2
instance_type    = "t3.micro"
root_volume_size = 20
root_volume_type = "gp3"

# Key Pair
key_pair_name   = "certifyhub-key"
public_key_path = "C:/Users/prani/.ssh/ec2.pub"
