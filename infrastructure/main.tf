provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-00f07845aed8c0ee7" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  key_name      = var.key_name

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "FullstackAppServer"
  }
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}

#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum install docker -y",
#       "sudo service docker start",
#       "sudo usermod -a -G docker ec2-user"
#     ]
#   }

#   connection {
#     type        = "ssh"
#     user        = "ec2-user"
#     private_key = file(var.private_key_path)
#     host        = self.public_ip
#   }
# }



