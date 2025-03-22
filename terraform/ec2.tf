# EC2 Instance Creation
resource "aws_instance" "travos_terraform" {
  ami           = var.aws_ami_id  # Update with the correct AMI for your region
  instance_type = "t2.micro"
  key_name      = var.aws_key_name # Ensure the key pair exists

  security_groups = [aws_security_group.travos_sg.name]

  tags = {
    Name = "TravosInstance"
  }
}