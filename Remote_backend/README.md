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

You want to reset backend settings without migrating state

⚡ Summary

-migrate-state → Moves state to new backend

-reconfigure → Resets backend config, no state migration
