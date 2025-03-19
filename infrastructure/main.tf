# main.tf

#########################################
# Remote State Backend Configuration
#########################################
terraform {
  backend "s3" {
    bucket         = "travos-terraform-state-bucket"  # Ensure this is the same bucket name from bootstrap
    key            = "ec2/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"  # Pre-created DynamoDB table for state locking
    encrypt        = true  # Encrypt the state file in S3
  }
}

#########################################
# Provider Configuration
#########################################
provider "aws" {
  region = "eu-central-1"
}

#########################################
# IAM Role and Instance Profile for EC2
#########################################
resource "aws_iam_role" "ec2_role" {
  name = "terraform-ec2-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "terraform-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_basic" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

#########################################
# Security Group for the EC2 Instance
#########################################
resource "aws_security_group" "travos_sg" {
  name_prefix = "terraform-ec2-sg"
  description = "Security group for the EC2 instance"
  vpc_id      = "vpc-0aef8362527dd3b3a"  # Replace with your VPC ID

  ingress {
    description = "Allow SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your-ip-address/32"]  # Replace with your IP address for SSH access
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#########################################
# EC2 Instance Creation
#########################################
resource "aws_instance" "travos_terraform" {
  ami           = "ami-00f07845aed8c0ee7"  # Replace with your desired AMI ID (e.g., Amazon Linux 2)
  instance_type = "t2.micro"  # Free Tier eligible instance type
  key_name      = var.key_name  # Ensure this variable is defined in your `variables.tf`

  vpc_security_group_ids = [aws_security_group.travos_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "Terraform-Travos-Instance"
  }
}

#########################################
# Outputs
#########################################
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.travos_terraform.public_ip
}


# provider "aws" {
#   region = "eu-central-1"
# }

# # Fetch existing instance by Name tag
# data "aws_instances" "existing_instance" {
#   filter {
#     name   = "tag:Name"
#     values = ["TravosAnsibleTerrafromServer"]
#   }

#   # Ensure we are only looking at running instances
#   filter {
#     name   = "instance-state-name"
#     values = ["running"]
#   }
# }

# # If an instance exists, get the instance ID
# data "aws_instance" "existing_instance_details" {
#   count       = length(data.aws_instances.existing_instance.ids) > 0 ? 1 : 0
#   instance_id = data.aws_instances.existing_instance.ids[0]
# }

# # Check if the instance exists
# locals {
#   instance_exists = length(data.aws_instances.existing_instance.ids) > 0
# }

# # Conditionally create a new instance if none exists
# resource "aws_instance" "app_server" {
#   count = local.instance_exists ? 0 : 1

#   ami           = "ami-00f07845aed8c0ee7" # Amazon Linux 2 AMI
#   instance_type = "t2.micro"
#   key_name      = var.key_name

#   vpc_security_group_ids = [aws_security_group.app_sg.id]

#   tags = {
#     Name = "TravosAnsibleTerrafromServer"
#   }

#   lifecycle {
#     ignore_changes = [
#       ami,
#       instance_type,
#       key_name
#     ]
#   }
# }

# # Create a security group (replace or modify as needed)
# resource "aws_security_group" "app_sg" {
#   name        = "app-security-group"
#   description = "Allow inbound traffic for application"
#   vpc_id      = "vpc-0aef8362527dd3b3a" # Replace with your VPC ID

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
#   }

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere
#   }

#   ingress {
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allow access to React frontend
#   }

#   ingress {
#     from_port   = 5000
#     to_port     = 5000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allow access to Flask backend
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
#   }
# }

# # Output the public IP of the existing or newly created instance
# output "public_ip" {
#   value = local.instance_exists ? data.aws_instance.existing_instance_details[0].public_ip : aws_instance.app_server[0].public_ip
# }




