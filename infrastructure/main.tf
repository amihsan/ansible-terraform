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

output "public_ip" {
  value = aws_instance.app_server[*].public_ip
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

