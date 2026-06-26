resource "aws_iam_role" "lambda_exec" {
  name = "efs-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# 1. Basic VPC Access (Required to run Lambda in a VPC)
resource "aws_iam_role_policy_attachment" "vpc_access" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# 2. Custom EFS Permissions
resource "aws_iam_policy" "efs_client_access" {
  name        = "LambdaEFSClientPolicy"
  description = "Allows Lambda to mount and write to EFS"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess"
        ]
        Resource = "*" # Scope this to your EFS ARN for tighter security
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "efs_access" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.efs_client_access.arn
}