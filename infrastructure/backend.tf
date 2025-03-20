terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"  # The name of the bucket
    key            = "terraform/state/terraform.tfstate"  # Path to the state file
    region         = "eu-central-1"  # Your AWS region
    dynamodb_table = "travos-terraform-lock-table"  # The DynamoDB table for state locking
    encrypt        = true  # Enable encryption for the state file
  }
}
