📦 AWS File Storage Lambda with EFS (Terraform)

This project demonstrates how to deploy an AWS Lambda function integrated with Amazon EFS
using Terraform. It enables persistent file storage for serverless workloads.

🚀 Getting Started
✅ Prerequisites

Ensure the following tools are installed and configured:

AWS CLI (configured with required IAM permissions)

Terraform v1.0+

Python 3.9+

Basic understanding of VPC, Lambda, and EFS

📁 Project Structure
aws-file-storage-lambda/
│── src/
│ └── index.py
│── lambda_function.zip
│── main.tf
│── variables.tf
│── outputs.tf
⚙️ Step 1: Package the Lambda Function

Terraform expects a deployment package (.zip file).

zip -j lambda_function.zip src/index.py

💡 Tip:
For production use, include dependencies:

pip install -r requirements.txt -t package/
cd package && zip -r ../lambda_function.zip .
cd .. && zip -g lambda_function.zip src/index.py
🏗️ Step 2: Initialize & Deploy Infrastructure

# Initialize Terraform providers

terraform init

## Preview infrastructure changes

terraform plan

## Deploy resources

terraform apply -auto-approve
🧪 Step 3: Test the Lambda Function

## Invoke the function using AWS CLI:

aws lambda invoke \
 --function-name efs-processor \
 --payload '{"file_name": "hello_efs.txt"}' \
 response.json

View the response:

cat response.json

✔️ This validates read/write operations on EFS.

🧹 Cleanup Resources

To avoid unnecessary costs:

## terraform destroy -auto-approve

🧠 Architecture Overview

AWS Lambda runs inside a VPC

Connected to Amazon EFS via mount targets

Uses NFS v4.1 protocol for file operations

IAM role grants access to EFS and logging

💡 Key Considerations & Best Practices

1. 📂 Storage Options:

Default: Amazon EFS (NFS v4.1)

Alternatives:

Amazon FSx (NetApp ONTAP) → for SMB/CIFS, enterprise storage features

S3 → for object storage use cases

2. 🔐 IAM Permissions

Ensure least-privilege access:

Lambda execution role:

elasticfilesystem:ClientMount

elasticfilesystem:ClientWrite

logs:\*

3. ⚡ Performance & Concurrency

EFS supports high concurrency, but consider:

Bursting mode → cost-effective, variable throughput

Provisioned mode → consistent performance

Align Lambda reserved concurrency with EFS throughput

4. 🌐 Networking

Lambda must run in private subnets

Ensure:

Security Group allows NFS (port 2049)

Proper routing (NAT Gateway if internet access required)

5. 📦 Deployment Improvements

Use Terraform archive_file data source instead of manual zip:

data "archive_file" "lambda_zip" {
type = "zip"
source_file = "src/index.py"
output_path = "lambda_function.zip"
}

## 6. 📊 Monitoring & Logging

Enable:

CloudWatch Logs

Lambda Insights (optional)

Track:

Duration

Errors

Throttles

7. ## 🔁 CI/CD Integration:

Integrate with:

GitHub Actions / GitLab CI

Steps:

Lint code

Package Lambda

Run terraform plan

Manual approval → apply

📌 Use Cases:

File processing pipelines

Shared storage across Lambda functions

ML model loading

Media processing workloads

🧩 Possible Enhancements:

Add API Gateway trigger

Implement S3 → Lambda → EFS pipeline

Add Terraform modules for reusability

Enable encryption at rest (EFS + KMS)

Add backup policies
