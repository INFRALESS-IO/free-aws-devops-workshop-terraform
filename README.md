# free-aws-devops-workshop

# REQUIREMENTS


# CREDENTIALS

To specify an AWS profile within your Terraform configuration, you can use the profile attribute in the provider block. AWS profiles are managed through the AWS CLI's configuration file (~/.aws/credentials and ~/.aws/config on Linux and macOS, %USERPROFILE%\.aws\credentials and %USERPROFILE%\.aws\config on Windows). Profiles allow you to store credentials for multiple AWS accounts and easily switch between them. This is particularly useful if you're managing resources across different AWS accounts or environments.

# STEPS

1. Init Terraform

```
terraform init
```

What's Next:

1. Store state file remotely
2. Separate states per workspace / environment
3. Set variables scope to limit data input
4. Setup Terraform access via roles instead profiles
5. Add S3 bucket
6. Update instance role to provide access to S3

ECS
1. Add Auto Scaling
2. 
