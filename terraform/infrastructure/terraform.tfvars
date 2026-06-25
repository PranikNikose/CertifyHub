project_name = "certifyhub"
environment  = "dev"

aws_region = "ap-south-1"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

availability_zone = "ap-south-1a"
ec2_instance_type = "t2.micro"
key_pair_name     = "certifyhub-key"

db_name              = "certifyhub"
db_username          = "certifyhub"
db_password          = "certifyhub123"
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20