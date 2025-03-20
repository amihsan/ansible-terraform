terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "travo-terraform-lock-table"
  }
  backend "dynamodb" {
    table = "travos-terraform-lock-table"
    region = "eu-central-1"
  }
}
