provider "aws" {
  region = "eu-central-1"
}

# S3 Bucket for Terraform Remote State (with security best practices)
resource "aws_s3_bucket" "travos_terraform_state" {
  bucket        = "travos-terraform-state-bucket"  # Ensure globally unique name
  tags = {
    Name        = "terraform-state"
    Environment = "prod"
  }

  
}
# Enforce Bucket Ownership (Replaces ACL)
resource "aws_s3_bucket_ownership_controls" "travos_s3_ownership" {
  bucket = aws_s3_bucket.travos_terraform_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
# Enable S3 Versioning (Required for state rollback)
resource "aws_s3_bucket_versioning" "travos_versioning" {
  bucket = aws_s3_bucket.travos_terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}


# DynamoDB Table for Terraform State Locking
resource "aws_dynamodb_table" "travos_terraform_lock" {
  name         = "travos-terraform-lock-table"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"  # Cost-efficient for small deployments

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-locks"
    Environment = "prod"
  }
}
