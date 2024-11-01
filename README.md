[![CI/CD for Travos App](https://github.com/amihsan/travos-trust-app/actions/workflows/docker-build-deploy.yml/badge.svg)](https://github.com/amihsan/travos-trust-app/actions/workflows/docker-build-deploy.yml)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue?logo=docker)](https://www.docker.com/)

## 💡 About

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

1. Install MongoDB on your local machine.

2. Clone the Git repository for both frontend and backend.

3. Setup npm in the frontend root directory:

   ```shell
   npm install
   ```

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
   npm start
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

### Deployment Steps

Each time you push to the main branch, the GitHub Actions workflow automatically triggers deployment. The process includes:

1. Terraform provisioning or updating AWS resources (e.g., EC2 instance).
2. Ansible managing the deployment of the Flask backend and React frontend containers directly.
