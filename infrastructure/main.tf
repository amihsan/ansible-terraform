provider "aws" {
  region = "eu-central-1"
}

# Data source to get the existing instance
data "aws_instance" "existing_instance" {
  instance_id = "i-05b21ea00177df05e" # Replace with your existing instance ID
}

# Check if the existing instance is found
locals {
  instance_exists = length(data.aws_instance.existing_instance.id) > 0
}

# Create a new instance only if no existing instance is found
resource "aws_instance" "app_server" {
  count = local.instance_exists ? 0 : 1

  ami           = "ami-00f07845aed8c0ee7" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = var.key_name

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "FullstackAppServer"
  }

  lifecycle {
    ignore_changes = [
      ami,
      instance_type,
      key_name
    ]
  }
}

# Security group configuration (replace or update as needed)
resource "aws_security_group" "app_sg" {
  name        = "app-security-group"
  description = "Allow inbound traffic for application"
  vpc_id      = "vpc-0023898c14a558e85" # Replace with your VPC ID

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
    from_port   = 3000
    to_port     = 3000
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
}

# Output the public IP of the existing or newly created instance
output "instance_public_ip" {
  value = local.instance_exists ? data.aws_instance.existing_instance.public_ip : aws_instance.app_server[0].public_ip
}






# provider "aws" {
#   region = "eu-central-1"
# }

# resource "aws_instance" "app_server" {
#   ami           = "ami-00f07845aed8c0ee7" # Amazon Linux 2 AMI
#   instance_type = "t2.micro"
#   key_name      = var.key_name

#   # Associate the security group
#   vpc_security_group_ids = [aws_security_group.app_sg.id]

#   tags = {
#     Name = "FullstackAppServer"
#   }
# }

# output "public_ip" {
#   value = aws_instance.app_server.public_ip
# }

