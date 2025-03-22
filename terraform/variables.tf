variable "aws_account_id" { default = "597088026267" }
variable "aws_region" { default = "eu-central-1" } # Change this to your preferred AWS region
variable "aws_key_name" { default = "travos_terraform_key" } # Change this to your preferred key pair name
variable "aws_ami_id" { default = "ami-03074cc1b166e8691" }
variable "aws_s3_bucket" { default = "travos-terraform-state-bucket" }
# variable "github_org" { default = "amihsan" } # Change this to your GitHub organization
# variable "github_repo" { default = "*"} # For all repos
# variable "github_repo" { default = "ansble-terraform"} # Uncomment this line if you want to use a specific repo
