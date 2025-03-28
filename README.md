[![CI/CD for Travos App](https://github.com/amihsan/travos-trust-app/actions/workflows/docker-build-deploy.yml/badge.svg)](https://github.com/amihsan/travos-trust-app/actions/workflows/docker-build-deploy.yml)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue?logo=docker)](https://www.docker.com/)

## 💡 About
This is part of the Master Thesis [trustlab](https://github.com/amihsan/trustlab_host/tree/ecd1923a44bbbbb7b1b38b2679bf6bb2871183b6/trust/artifacts/travos) project.

This repository contains the TRAVOS app, which integrates both the frontend and backend logic of the application. The app is deployed on AWS EC2 using GitHub Actions with Ansible, Terraform. For local development, you can use Docker Compose, Ansible, Minikube, and Kubernetes.

## View Demo

[Live Demo](https://react-travos-app.vercel.app/)

### 🧱 Built With

1. React
2. Python 3
3. Flask
4. npm
5. MongoDB
6. Ansible
7. Terraform
8. Docker Compose
9. Kubernetes (for local PC deployment)

## ⚡ Getting Started

### ⚙️ Local Setup

1. Install MongoDB

2. Clone Git Repository, both frontend and backend.

3. Setup npm in frontend root:

   ```shell
   npm install
   ```

4. Setup virtual env in backend root:
   ```shell
   python -m venv venv
   ```
5. To activate the virtual environment:

   - On Windows:

   ```bash
   .\venv\Scripts\activate
   ```

   - On macOS/Linux:

   ```bash
   source venv/bin/activate
   ```

   To install the Python dependencies specified in your `requirements.txt` file, use the following command:

   ```bash
   pip install -r requirements.txt
   ```

## 👟 Usage

### 🏠 Local Usage

1. Run local MongoDB

2. Run frontend:

   ```bash
   npm run dev
   ```

3. Run backend: after activate venv:

   For storing scenario details in MongoDB go to generate_scenario

   ```bash
   python insert_scenario_data.py
   ```

   and then in backend root:

   ```bash
   python app.py
   ```

### ⛴️ Docker Usage

For Docker MongoDB atlas is used. Nginx is used used to serve react build and proxy to backend flask api.

##### For Production:

```bash
docker-compose.yml up -d
```

## 🖥️ Local Deployment with Kubernetes and Minikube

For local deployment using Minikube and Kubernetes, follow the steps below:

### Install Required Tools

- Ansible
- Minikube
- Kubectl

### Set Up Kubernetes Cluster

#### 🔐 Encrypting Sensitive Data with Ansible Vault

Ansible Vault allows you to encrypt sensitive data such as passwords and API keys, keeping them secure while using them in your Ansible playbooks. Follow these steps to encrypt your sensitive data:

#### Creating an Encrypted Vault

1. **Create a New Vault File**:
   Use the following command to create a new encrypted vault file:

   ```bash
   ansible-vault create secrets.yml
   ```

   This will prompt you to enter a password to secure the vault.

2. **Edit the Vault File**: After entering the password, an editor will open. You can add your sensitive information in this file.
3. **Save and Exit**: After adding your secrets, save the file and exit the editor. The contents are now encrypted and securely stored.

If Minikube and Kubernetes aren't installed, Ansible can automate their installation. Run the Ansible playbook provided in the repository to install necessary dependencies and deploy the application on your local Kubernetes cluster:

```bash
ansible-playbook -i localhost local-kubernetes-playbook.yml --ask-vault-pass
```

This will prompt you to enter the password used for encryption.

## 🌍 Cloud Deployment on AWS EC2

This project is deployed using GitHub Actions for CI/CD. It utilizes Terraform to manage AWS resources and Ansible to configure and deploy the app on EC2 instances.

### Prerequisites

Install the following tools locally if needed:

- Ansible
- Terraform
- AWS CLI

Ensure you have an AWS account with access to EC2, and an SSH key pair for connecting to your instance.

Make sure Docker is installed on the EC2 instance, which Ansible will manage.

### Setting Up GitHub Secrets

For continuous deployment via GitHub Actions, the following GitHub secrets must be configured in your repository:

- `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID
- `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key
- `ANSIBLE_PRIVATE_KEY`: The SSH private key (PEM file) to connect to your EC2 instance
- `ANSIBLE_VAULT_PASSWORD`: Your Ansible Vault password for securing sensitive information
- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Your Docker Hub password

You can set these in the repository by navigating to **Settings > Secrets > Actions**.

## 🛠️ Setting Up GitHub OIDC Provider and IAM Role in AWS

This guide explains how to set up a GitHub OpenID Connect (OIDC) provider in AWS, create an IAM role for GitHub Actions, and configure specific access to GitHub organizations, repositories, and branches for seamless authentication from GitHub Actions to AWS.

#### Step 1: Add GitHub OIDC Provider in AWS

- **Go to AWS IAM Console**

  - Open the [AWS IAM Console](https://console.aws.amazon.com/iam/).

- **Navigate to Identity Providers**

  - In the left sidebar, click on **Identity Providers** under the **Access Management** section.

- **Add a New Identity Provider**

  - Click on the **Add Provider** button.

- **Select Provider Type**

  - Choose **OpenID Connect** as the provider type.

- **Enter Provider Details**

  - **Provider URL**: `https://token.actions.githubusercontent.com`
  - **Audience**: `sts.amazonaws.com`

- **Save the Provider**
  - Click on **Add Provider** to finalize the process.

Now, GitHub Actions can use this OIDC provider to authenticate securely with AWS.

#### Step 2: Create IAM Role (GitHubActionsTerraformRole)

After setting up the OIDC provider, create an IAM role that GitHub Actions can assume for AWS access.

- **Go to AWS IAM Console**
  - Open the [AWS IAM Console](https://console.aws.amazon.com/iam/).
- **Navigate to Roles**

  - In the left sidebar, click on **Roles**.

- **Create a New Role**

  - Click on the **Create Role** button.

- **Set Trusted Entity Type**
  - Choose **Web identity** as the trusted entity type.
- **Select Identity Provider**

  - Select **token.actions.githubusercontent.com** as the identity provider.

- **Set Audience**

  - Choose **sts.amazonaws.com** as the audience.

- **Set GitHub organization**

  - If you're using an organization, enter its name (e.g., my-org).

  - If you're using a personal account, enter your GitHub username (e.g., my-username).

- **Attach Permissions**

  - Attach the following permissions:
    - **AmazonS3FullAccess** (for Terraform remote backend in S3)
    - **AmazonEC2FullAccess** (or custom EC2 permissions)

- **Complete the Role Creation**

  - Click **Next**, review the configuration, and click **Create Role**.

- **Copy the Role ARN**
  - Copy the Role ARN, which is needed for the GitHub Actions workflow:
  ```ruby
  arn:aws:iam::123456789012:role/GitHubActionsTerraformRole
  ```

Replace `123456789012` with your AWS account ID.

#### Step 3: Add a Trust Policy to the IAM Role

- **Navigate to the Role**  
   In the AWS IAM console, go to **Roles** and select the `GitHubActionsTerraformRole`.

- **Edit the Trust Policy**  
   Under the **Trust relationships** tab, click **Edit trust policy**.

- **Update the Trust Policy**  
   Replace the existing policy with the following JSON, making sure to replace the placeholders with your own AWS account ID and GitHub repository information:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          },
          "StringLike": {
            "token.actions.githubusercontent.com:sub": "repo:your-github-org-or-username/your-repo:*"
          }
        }
      }
    ]
  }
  ```

Replace `123456789012` with your AWS account ID.

`"repo:your-github-org-or-username/your-repo:\*"` → Your GitHub repo

Example: `"repo:my-org/my-terraform-repo:\*"`

Click Update Policy ✅

#### Step 4: Update GitHub Actions Workflow

Finally, update your GitHub Actions workflow to use the new IAM role for authentication.

1- **Update the Workflow Configuration**  
 In your GitHub repository, edit the `.github/workflows/ec2-aws-deploy.yml` file.

- **Configure AWS Credentials**  
   Add or update the following step to configure AWS credentials using the IAM role you just created:

  ```yaml
  - name: Configure AWS Credentials
    uses: aws-actions/configure-aws-credentials@v2
    with:
      role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsTerraformRole
      aws-region: eu-central-1
  ```

Replace `123456789012` with your AWS account ID.

## 🚀 Deployment Steps

Each time you push to the main branch, the GitHub Actions workflow automatically triggers deployment. The process includes:

- Terraform provisioning or updating AWS resources (e.g., EC2 instance).
- Ansible managing the deployment of the Flask backend and React frontend containers directly.
