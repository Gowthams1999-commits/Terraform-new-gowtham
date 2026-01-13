# Create a Lambda Function using terraform

lambda-terraform/
│── main.tf
│── variables.tf
│── outputs.tf
│── lambda/
│    └── index.py

## Lambda Function Code

👉 lambda/index.py

def handler(event, context):
    return {
        "statusCode": 200,
        "body": "Hello from Terraform Lambda!"
    }


## Zip the Lambda Code (Terraform will use this)


cd lambda
zip lambda.zip index.py
cd ..


## Terraform Provider Config

👉 main.tf

provider "aws" {
  region = "ap-south-1"   # Mumbai region
}


## IAM Role for Lambda

👉 Add to main.tf

resource "aws_iam_role" "lambda_role" {
  name = "lambda_basic_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}


👉 Attach basic logging policy

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


## Create Lambda Function

👉 Add to main.tf

resource "aws_lambda_function" "my_lambda" {
  function_name = "terraform-demo-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.10"

  filename         = "lambda/lambda.zip"
  source_code_hash = filebase64sha256("lambda/lambda.zip")

  timeout = 10
}


##  Initialize & Deploy

terraform init
terraform plan
terraform apply

## Test Lambda Function
From AWS Console:

1. Go to Lambda

2. Select terraform-demo-lambda

3. Click Test

You should see:

Hello from Terraform Lambda!
