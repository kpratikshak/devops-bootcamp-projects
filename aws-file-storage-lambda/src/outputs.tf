output "lambda_function_name" {
  description = "The name of the deployed Lambda function"
  value       = module.compute.function_name
}

output "efs_id" {
  description = "The ID of the created EFS file system"
  value       = module.storage.efs_id
}

output "vpc_id" {
  description = "The VPC ID where the infrastructure resides"
  value       = module.network.vpc_id
}

output "mount_point_path" {
  description = "The local path inside the Lambda where EFS is mounted"
  value       = "/mnt/efs"
}