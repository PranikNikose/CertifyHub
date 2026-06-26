#########################################
# KEY PAIR
#
# Creates an EC2 Key Pair using
# the local SSH public key.
#########################################

resource "aws_key_pair" "main" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-keypair"
    }
  )

}