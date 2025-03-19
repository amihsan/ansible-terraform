# variables.tf
variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the EC2 key pair"
  type        = string
}
