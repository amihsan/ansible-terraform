# S3 Bucket for Terraform Remote State
resource "aws_s3_bucket" "travos_terraform_state" {
  bucket        = "travos-terraform-state-bucket"  # Ensure globally unique name
  force_destroy = false  # Prevent accidental deletion

  lifecycle {
    prevent_destroy = true
  }
}

# Enforce Bucket Ownership (Replaces ACL)
resource "aws_s3_bucket_ownership_controls" "travos_s3_ownership" {
  bucket = aws_s3_bucket.travos_terraform_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Enable S3 Versioning
resource "aws_s3_bucket_versioning" "travos_versioning" {
  bucket = aws_s3_bucket.travos_terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enforce Server-Side Encryption (SSE)
resource "aws_s3_bucket_server_side_encryption_configuration" "travos_sse" {
  bucket = aws_s3_bucket.travos_terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Restrict Public Access
resource "aws_s3_bucket_public_access_block" "travos_s3_block" {
  bucket = aws_s3_bucket.travos_terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
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

  lifecycle {
    prevent_destroy = true
  }
}
