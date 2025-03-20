terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}
