# AWS Terraform Infrastructure Deployment Guide

## Important Notes before you start

### Introduction to Terraform and AWS

This Terraform script serves as a baseline introduction to using Terraform for deploying AWS resources. It is essential to understand that:

1. **DevOps Best Practices**: The configurations provided here are intended for educational purposes and do not encompass all DevOps best practices. They serve as an introductory guide to Terraform and AWS. We plan to cover improvements, more sophisticated practices, and deeper insights into Terraform and AWS in future DevOps sessions.

### Workshop Scope

2. **Workshop Focus**: The Terraform files presented are designed to demonstrate the setup of a basic multi-tier application infrastructure on AWS, focusing on essential services like VPC, subnets, and ECS. Please note, for the sake of simplicity in this workshop, certain best practices and configurations may be omitted. This approach allows us to concentrate on the core functionalities of Terraform and AWS, making it easier for beginners to grasp the fundamental concepts.

### Join Our Community

3. **Continuous Learning**: For those eager to expand their knowledge on AWS, Terraform, and DevOps, we highly encourage joining our AWS & DevOps Academy WhatsApp group. It's a fantastic opportunity to be notified about upcoming workshops, share experiences, and connect with fellow enthusiasts and professionals. Click [here](https://chat.whatsapp.com/I6UjXJYlrl2JXfhGFniOZX) to join our WhatsApp group and become part of our learning community.

## What will you learn here - Infrastructure Overview

The Terraform script provided outlines the deployment of a robust AWS infrastructure designed to support a web application. Below is a brief overview of the components created and their roles in the infrastructure:

### AWS VPC (Virtual Private Cloud)

- **Purpose**: Establishes the network foundation for deploying AWS resources. It's configured with a custom CIDR block to facilitate network segmentation and control over IP addressing.

### Internet Gateway

- **Purpose**: Connects the VPC to the internet, enabling communication between resources in the VPC and the outside world.

### Subnets

The script defines three types of subnets within the VPC:

- **Public Subnets**: Host resources that need to be accessible from the internet. Each public subnet is associated with a route table that directs traffic to the internet gateway.
- **Private Subnets**: Designed for resources that should not be directly accessible from the internet. Access to the internet from these subnets is routed through a NAT Gateway, allowing outbound internet access without direct inbound access.
- **Secure Subnets**: Likely intended for highly sensitive workloads, these subnets have their distinct routing and security measures, though specifics are not detailed in the script.

### NAT Gateway

- **Purpose**: Ensures that instances in the private subnet can initiate outbound internet traffic (e.g., for updates) without being directly accessible from the internet.

### Route Tables and Associations

- **Purpose**: Direct traffic from the subnets to the internet gateway or NAT Gateway, depending on whether the subnet is public or private.

### Elastic IP (EIP)

- **Purpose**: A static IPv4 address associated with the AWS account, used by the NAT Gateway to enable outbound internet access for instances in private subnets.

### AWS ECS (Elastic Container Service) Cluster

- **Purpose**: Configured to run containerized applications. The ECS services and tasks can run on AWS Fargate, a serverless compute engine for containers, which abstracts the server management aspect.

### AWS ECR (Elastic Container Registry) Repository

- **Purpose**: Stores Docker container images, making them available for ECS to deploy.

### Application Load Balancer (ALB)

- **Purpose**: Distributes incoming application traffic across multiple targets, such as ECS tasks, in multiple Availability Zones, increasing the fault tolerance of the application.

### AWS Route 53 Record

- **Purpose**: Configures a DNS record to map a domain name to the ALB, facilitating user access to the web application via a friendly URL.

### Security Groups and IAM Policies

- **Purpose**: Define the rules and policies that govern access to the resources, ensuring secure communication and operation within the AWS environment.

This Terraform script represents a comprehensive setup for a web application, including networking, compute, and security components, providing a scalable and secure environment ready for deployment.


## Lets Get Started

- [Prerequisites](#prerequisites)
- [Setting Up AWS CLI](#setting-up-aws-cli)
- [Installing Terraform](#installing-terraform)
- [Configuring AWS Profiles](#configuring-aws-profiles)
- [Cloning the Terraform Scripts](#cloning-the-terraform-scripts)
- [Initializing Terraform](#initializing-terraform)
- [Creating a Terraform Variables File](#creating-a-terraform-variables-file)
- [Running Terraform Plan](#running-terraform-plan)
- [Applying Terraform Changes](#applying-terraform-changes)
- [Accessing the Outputs](#accessing-the-outputs)
- [Deleting the Infrastructure](#deleting-the-infrastructure)

## Prerequisites

Before starting, ensure you have administrative access to an AWS account and have the following installed:

- An AWS Account
- AWS CLI
- Terraform
- A Route53 with a valid domain configured. The ROUTE 53 zone id needs to be configured in the terraform.tfvars file.

## Setting Up AWS CLI

Install and configure the AWS CLI by following the official guides for your operating system:

- **MacOS**: [Installing the AWS CLI version 2 on macOS](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html)
- **Windows**: [Installing the AWS CLI version 2 on Windows](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)
- **Linux**: [Installing the AWS CLI version 2 on Linux](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html)

## Installing Terraform

Follow the Terraform documentation to install Terraform on your system:

- **MacOS**: [Install Terraform on macOS](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform)
- **Windows**: [Install Terraform on Windows](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform)
- **Linux**: [Install Terraform on Linux](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started#install-terraform)

## Configuring AWS Profiles

1. Use the AWS CLI to configure your profile. Replace `workshop-1` with your desired profile name.

    ```bash
    aws configure --profile workshop-1
    ```

Follow the prompts to input your AWS Access Key ID, Secret Access Key, region, and output format.

## Cloning the Terraform Scripts

If applicable, clone your repository or navigate to your project directory containing the Terraform configuration files.

## Initializing Terraform

Initialize your Terraform workspace, which will download the provider and initialize it with the settings provided in the `terraform` block.

```bash
terraform init
```

## Running Terraform Plan

Generate and review an execution plan for Terraform:


```bash
terraform plan
```

## Applying Terraform Changes

Apply the changes required to reach the desired state of the configuration:


```bash
terraform apply
```

Type yes when prompted to apply the proposed actions.


## Accessing the Outputs

After the apply process completes, you can see the outputs by running:

```bash
terraform output
```

## Deleting the Infrastructure

To destroy the Terraform-managed infrastructure:

```bash
terraform destroy
```

Confirm by typing yes when prompted.

## Deploying the Application

Once the infrastructure setup is complete, you are ready to deploy the application. Detailed instructions for deploying the application can be found in the following repository: [INFRALESS-IO/free-aws-devops-workshop-application](https://github.com/INFRALESS-IO/free-aws-devops-workshop-application).

Please follow the steps outlined in the repository to deploy your application onto the newly created AWS infrastructure. The repository provides a comprehensive guide to ensure a smooth deployment process.


## Reporting Issues and Suggesting Improvements

If you encounter any issues or have suggestions for improvements while using these Terraform scripts, we encourage you to use the GitHub Issues tab associated with this repository. Your feedback is invaluable in helping us enhance and maintain the quality of our codebase.

- **Reporting Issues**: Please provide a detailed description of the issue, including the steps to reproduce it, and, if possible, screenshots or error messages.
- **Suggesting Improvements**: We welcome your suggestions for making our Terraform scripts more efficient, secure, or user-friendly. Please include as much detail as possible about your proposed improvements.

We will review submissions through the GitHub Issues tab and aim to update the code based on your valuable feedback.


## AWS Billing and Resource Management Notice

**Important**: While deploying and managing AWS resources using Terraform scripts, it's crucial to monitor your AWS billing dashboard regularly. Deploying resources on AWS incurs costs, and it is the responsibility of the user to ensure that no unnecessary resources are left running. Unused or idle resources can significantly impact your AWS billing.

- **Proactive Monitoring**: Always keep an eye on the resources you've deployed and their associated costs in the AWS Management Console.
- **Clean Up**: Make it a habit to destroy resources that are no longer needed by running `terraform destroy` to avoid incurring unnecessary costs.
- **Budget Alerts**: Consider setting up billing alerts in AWS to notify you when your costs exceed a certain threshold.

Please be aware that **we are not responsible for any financial or data loss** that may occur due to the deployment and management of AWS resources. By using these Terraform scripts, you acknowledge and accept the responsibility for monitoring and managing AWS resource usage and costs.

