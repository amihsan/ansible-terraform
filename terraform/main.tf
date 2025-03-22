provider "aws" {
  region = "eu-central-1"
}

# Terraform Backend Configuration (After S3 and DynamoDB are created)
terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"  # The existing bucket name
    key            = "ec2/terraform.tfstate"  # Path to store the state file
    region         = "eu-central-1"
    use_lockfile   = true  # Enable lockfile for state locking
    encrypt        = true  # Enable encryption for state
  }
}

# EC2 Instance Creation
resource "aws_instance" "travos_terraform" {
  ami           = "ami-03074cc1b166e8691"  # Update with the correct AMI for your region
  instance_type = "t2.micro"
  key_name      = "travos_terraform_key"  # Ensure the key pair exists

  security_groups = [aws_security_group.travos_sg.name]

  tags = {
    Name = "TravosInstance"
  }
}

# Security Group for EC2
resource "aws_security_group" "travos_sg" {
  name        = "travos_sg"
  description = "Allow inbound traffic on port 22 for SSH and port 80 for HTTP"

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere
  }

  ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to React frontend
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access to Flask backend
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
    tags = {
    Name = "TravosSecurityGroup"
  }
}



# provider "aws" {
#   region = "eu-central-1"  # Ensure the provider region matches your S3 bucket
# }

# # Reference the existing S3 bucket (no creation)
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "travos-terraform-state-bucket"  # Using the existing bucket
# }

# # Enable S3 Versioning (Required for state rollback)
# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enforce Server-Side Encryption (SSE)
# resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
#   bucket = aws_s3_bucket.terraform_state.id

#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

# # Block Public Access to S3 Bucket
# resource "aws_s3_bucket_public_access_block" "block_public_access" {
#   bucket = aws_s3_bucket.terraform_state.id

#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

# # DynamoDB Table for State Locking
# resource "aws_dynamodb_table" "terraform_lock" {
#   name         = "terraform-lock"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }

# # Terraform Backend Configuration (Applied After First Run)
# terraform {
#   backend "s3" {
#     bucket         = "travos-terraform-state-bucket"  # The existing bucket name
#     key            = "ec2/terraform.tfstate"  # Path to store the state file
#     region         = "eu-central-1"  # Ensure region matches your provider
#     use_lockfile   = true           # Use lockfile for state locking
#     encrypt        = true           # Enable encryption for state
#     dynamodb_table = "terraform-lock"  # DynamoDB table for state locking
#   }
# }

# # EC2 Instance
# resource "aws_instance" "my_ec2" {
#   ami           = "ami-03074cc1b166e8691"  # Update to your region's AMI
#   instance_type = "t2.micro"
#   key_name      = "travos_terraform_key"  # Ensure the key pair exists

#   security_groups = [aws_security_group.ec2_sg.name]

#   tags = {
#     Name = "MyTerraformEC2"
#   }
# }

# # Security Group for EC2
# resource "aws_security_group" "ec2_sg" {
#   name        = "ec2-security-group"
#   description = "Allow SSH and HTTP"

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
