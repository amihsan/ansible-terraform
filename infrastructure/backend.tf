terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "travo-terraform-lock-table"
  }
}
