provider "aws" {
  region = var.aws_region
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


