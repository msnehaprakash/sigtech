# README.md
  This project is divided into two main components:

## 1. Terraform EC2 Module and GitHub Actions Pipeline 
   This component manages the infrastructure provisioning using Terraform and automates the deployment process through GitHub Actions.

## 2. Containerizing a Python Application with MySQL
   This component involves containerizing a Python application and a MySQL database using Docker and Docker Compose to ensure a consistent development and deployment environment.

## Triggering the Pipeline
To trigger the GitHub Actions pipeline, follow these steps:

1. Switch to the dev branch in the repository. The code to be reviewed is in ```Dev branch```. To run locally clone the Dev branch.
2. Maker sure Docker Daemon is running.
3. Create a new pull request, ensuring that the changes are from ```compare: dev``` to ```base: main```
4. The pipeline will automatically be triggered upon creating the pull request.
5. The 'terraform job' upon successful run will give a terraform plan where as the 'docker compose operations' job will dispay ```You are connected to database ('test_database',)``` message upon successful run.


## File Structure
* .
* docker/
    * docker-compose.yml
    * Dockerfile
    * app.py
    * requirements.txt
*  ec2-module/
    * main.tf
    * outputs.tf
    * variables.tf
* main.tf
* variables.tf
* terraform.tfvars
* vpc.tf
* providers.tf
* .github/
    * workflows/
        * main.yml
* Makefile
* README.md



## Terraform EC2 Module and GitHub Actions Pipeline

### Overview

This project involves creating a Terraform module to deploy an EC2 instance within a private subnet of the default VPC, using input parameters such as Name, VPCID, SubnetID, AMI ID, and EC2 type (instance size). Additionally, a GitHub Actions pipeline is set up to run terraform plan upon each pull request and display the plan's output directly in the pull request for review. 

### Architecture diagram
![](/images/terraform.png)

#### EC2 Module
The Terraform module accepts the following input parameters:
- **Name :** The name tag for the EC2 instance.
- **VPCID :** The ID of the VPC where the instance will be deployed.
- **SubnetID :** The ID of the subnet within the VPC where the instance will be deployed.
- **AMI ID :** The Amazon Machine Image ID to be used for the instance.
- **EC2 type:** The type (size) of the EC2 instance.

#### GitHub Actions Pipeline
The GitHub Actions pipeline is configured to run terraform plan on each pull request. 
1. The workflow triggers on push to the dev branch and on any pull_request. branch.
2. The required permissions are set for the workflow to access AWS and interact with GitHub.
3. Global environment variables for logging and AWS region are defined.
4. Jobs and Steps:
    - **Checkout:** Checks out the repository.
    - **AWS Credentials:** Configures AWS credentials using OpenID Connect (OIDC) to assume a role.
    - **Setup Terraform:** Sets up Terraform CLI.
    - **Terraform Format:** Runs terraform fmt to check formatting.
    - **Terraform Init:** Initializes Terraform with backend configuration.
    - **Terraform Validate:** Validates the Terraform configuration.
    - **Terraform Plan:** Generates a Terraform execution plan.
    - **GitHub Script:** Comments the Terraform plan and other step outcomes on the pull request.
    - **Plan Status:** Fails the job if the Terraform plan step fails

This setup ensures that any changes made to the Terraform configuration are validated and reviewed via pull requests before being merged, maintaining a robust infrastructure management process.


## Containerizing a Python Application with MySQL

### Overview

This guide explains how to containerize a Python application that interacts with a MySQL database. The setup involves two interdependent services managed with Docker Compose, and the entire process is automated using GitHub Actions.

 ### Architecture diagram
![](/images/docker.png)

 ### Step-by-Step Process
- 1 Create a Python Application
Write a Python application ```app.py``` capable of interacting with a MySQL database running in a separate container. The ```mysql-connector-python``` module is used for the connection.
- 2 Build a Docker Image for the Python Application
Create a Dockerfile to containerise the Python application.
- 3 Define Services with Docker Compose
Use Docker Compose to manage the Python and MySQL services. Ensure that the Python service depends on the MySQL service.
- 4 Automate with Makefile
Create a Makefile to simplify the Docker Compose commands.
- 5 GitHub Actions Workflow
Create a GitHub Actions workflow to automate the build and deployment process. The workflow ensures that the application is built and deployed efficiently, with all commands and configurations centralized in a Makefile for ease of use
- The name of the workflow, "Docker Compose Operations" which runs on the latest version of Ubuntu on the successful completion of a previous job named terraform.
- Jobs and Steps:
    - Checks out the repository's code so that the workflow can access it
    - Sets up Docker Buildx, a tool for building and pushing multi-architecture Docker images.
    - Logs in to Docker Hub using credentials stored in GitHub Secrets (```DOCKER_USERNAME``` and ```DOCKER_PASSWORD)```). This allows subsequent steps to push images to Docker Hub.
    - Runs make build, make up, make down commands which is assumed to be a command defined in the project's Makefile to start Docker Compose services.
    - By automating these steps, the workflow ensures a consistent and repeatable process for managing Docker Compose services. 