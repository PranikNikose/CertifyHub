terraform {

  # NOTE:
  # Update the following values only when creating
  # a new project or migrating the Terraform backend.

  backend "s3" {

    bucket         = "certifyhub-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "certifyhub-terraform-lock"
    encrypt        = true

  }

}