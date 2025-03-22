provider "aws" {
  region = eu-central-1
}

resource "aws_iam_role" "github_actions_role" {
  name = "GitHubActionsTerraformRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Federated = "arn:aws:iam::597088026267:oidc-provider/token.actions.githubusercontent.com"
      },
      Action = "sts:AssumeRoleWithWebIdentity",
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:amihsan/*:ref:refs/heads/main"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "github_terraform_policy" {
  name        = "GitHubTerraformPolicy"
  description = "Policy for GitHub Actions to manage Terraform"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:*", "ec2:*", "iam:PassRole", "cloudwatch:*"],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "github_terraform" {
  name       = "GitHubTerraformPolicyAttachment"
  roles      = [aws_iam_role.github_actions_role.name]
  policy_arn = aws_iam_policy.github_terraform_policy.arn
}
