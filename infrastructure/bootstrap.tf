provider "aws" {
  region = "eu-central-1"
}

# S3 Bucket for Terraform Remote State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "travos-terraform-state-bucket"  # Ensure this name is globally unique
  force_destroy = true  # Allow the bucket to be destroyed even if it contains objects
}

# DynamoDB Table for State Locking (Free Tier - On-Demand Mode)
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock-table"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"  # On-Demand mode for Free Tier

  attribute {
    name = "LockID"
    type = "S"
  }
}
