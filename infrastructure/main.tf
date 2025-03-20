# Define the EC2 instance
resource "aws_instance" "travos_terraform" {
  ami           = "ami-03074cc1b166e8691"  # Example AMI, replace with your own
  instance_type = "t2.micro"  # Free Tier eligible instance
  key_name               = "travos_terraform_key" 
  vpc_security_group_ids = [aws_security_group.travos_sg.id]

  tags = {
    Name = "TravosInstance"
  }
}
