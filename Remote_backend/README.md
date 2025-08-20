# Terraform State File and Remote Backend

Terraform uses a state file (terraform.tfstate) to track infrastructure.
By default, this file is stored locally, but best practice is to store it in a remote backend like AWS S3.

🔹 Remote Backend with S3 and DynamoDB

S3 bucket → stores the Terraform state file.

DynamoDB table → provides state locking (to avoid race conditions when multiple people run Terraform).

Example backend config:

terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

🔹 Terraform v1.10.X Update (State Locking)

In Terraform 1.10.X, you can avoid using DynamoDB for state locking by enabling lockfiles:

terraform {
  backend "s3" {
    bucket       = "my-terraform-state"
    key          = "prod/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}


This creates a .tflock file inside the S3 bucket for state locking instead of requiring DynamoDB.

🔹 Difference Between -migrate-state and -reconfigure
1. terraform init -migrate-state

👉 Purpose: Moves your existing state from the old backend to the new backend.

Example:

# Initially state is local (terraform.tfstate file)
terraform init -migrate-state


Terraform will upload your local state into the new backend (e.g., S3).
This way, you don’t lose your infrastructure state.

✅ Use when:

Moving from local → remote backend

Moving from one remote backend → another

2. terraform init -reconfigure

👉 Purpose: Forget old backend settings and use the new ones, but don’t move state automatically.

Example:

# Old backend
backend "s3" {
  bucket = "my-terraform-state"
  key    = "prod/terraform.tfstate"
  region = "us-east-1"
}

# New backend
backend "s3" {
  bucket = "new-terraform-state"
  key    = "prod/terraform.tfstate"
  region = "us-east-1"
}

terraform init -reconfigure


Terraform will reinitialize the backend with the new config.
If you need the old state, you must move/copy it manually.

✅ Use when:

Backend configuration changed (new bucket, region, or credentials)


🔹 What is a Partial Backend Configuration?

Normally, you configure the backend fully inside your Terraform code (main.tf):

terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}


But sometimes you don’t want to hardcode everything in .tf files (for security or reusability reasons).
Example: bucket name, region, credentials.

👉 Instead, you declare only the backend type in code, and supply the rest during terraform init.
That’s called partial backend configuration.

🔹 Example of Partial Backend

In main.tf:

terraform {
  backend "s3" {}
}


Here, no details are provided.
When you run init, you supply them with --backend-config:

terraform init \
  -backend-config="bucket=my-terraform-state" \
  -backend-config="key=prod/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -migrate-state


or from a file:

terraform init \
  --backend-config=backend.hcl \
  -migrate-state



✅ Avoids hardcoding sensitive values (like bucket names, credentials).
✅ Lets you reuse the same Terraform code across multiple environments (dev, test, prod).
✅ Good for CI/CD pipelines where backend config is passed at runtime.

You want to reset backend settings without migrating state

⚡ Summary

-migrate-state → Moves state to new backend

-reconfigure → Resets backend config, no state migration
