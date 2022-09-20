provider "aws" {
  access_key                  = "accesskey"
  secret_key                  = "secretkey"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    iam      = "http://localhost:4566"
    lambda   = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    ssm      = "http://localhost:4566"
    kinesis  = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
  }
}


# Lambda
resource "aws_lambda_function" "main-lambda" {
  function_name = "main"
  filename      = "../../lambda.zip"
  description   = "Main service"
  memory_size   = 1024
  timeout       = 20
  handler       = "src.app.main"
  runtime       = "python3.8"
  role          = aws_iam_role.main-lambda-role.arn

  environment {
    variables = {
      LOG_LEVEL  = "INFO"
      AWS_REGION = "us-east-1"
    }
  }
}


# IAM
resource "aws_iam_role" "main-lambda-role" {
  name               = "main-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.main-lambda-role.json
}

data "aws_iam_policy_document" "main-lambda-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}