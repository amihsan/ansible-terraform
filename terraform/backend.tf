# Terraform Backend Configuration (After S3 and DynamoDB are created)
terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"  # The existing bucket name
    key            = "state/terraform.tfstate"  # Path to store the state file
    region         = "eu-central-1"
    use_lockfile   = true  # Enable lockfile for state locking
    encrypt        = true  # Enable encryption for state
  }
}