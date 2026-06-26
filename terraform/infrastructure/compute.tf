#########################################
# COMPUTE
#
# Resources:
# 1. Amazon Linux 2023 AMI
# 2. EC2 Instance
# 3. Elastic IP
#########################################

#########################################
# Amazon Linux 2023 AMI
#########################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

#########################################
# EC2 Instance
#########################################

resource "aws_instance" "main" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  key_name                    = aws_key_pair.main.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]
  iam_instance_profile = aws_iam_instance_profile.ec2.name
  user_data            = file("${path.module}/userdata.sh")
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = true

    delete_on_termination = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ec2"
    }
  )
}

#########################################
# Elastic IP
#########################################

resource "aws_eip" "main" {
  instance = aws_instance.main.id
  domain   = "vpc"
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eip"
    }
  )
}