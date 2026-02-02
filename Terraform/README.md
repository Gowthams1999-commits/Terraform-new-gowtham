# What is Terraform?
Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define, provision, and manage infrastructure using a declarative configuration language called HashiCorp Configuration Language (HCL).

In simpler terms, Terraform helps you automate and manage your cloud infrastructure (such as servers, networks, and databases) by writing code instead of manually configuring it via a user interface.

You can use Terraform to interact with different cloud providers (AWS, Azure, GCP, etc.), on-premises infrastructure, and even third-party services (like DNS or monitoring tools) via a plugin-based architecture.

## Terraform installation:
Follow Terraform official documention to install terraform

## AWS CLI installation:
Follow AWS decumentation to install AWS CLI and Configure AWS CLI to access aws resources.


**⚡ Summary (Most Commonly Used in Daily Work)

terraform init → initialize

terraform fmt → format code

terraform validate → check syntax

terraform plan → preview changes

terraform apply → create/update resources

terraform destroy → delete resources**

terraform show -> show terraform.tfstate in human readable format

terraform state list --> list resources in terraform state file

terraform output --> list output values

## 🔹 What is a terraform Block?

The terraform block is a special top-level block in a Terraform configuration. It defines settings that control how Terraform itself behaves, such as:

Which Terraform version is required

Which provider plugins to use

Where to store the state (backend configuration)

It is not about resources (like EC2, S3, etc.), but about Terraform itself. terraform state rm --> remove specify resources

Example :

terraform { 

required_version = ">= 1.3.0"

required_providers { 

aws = { 

source = "hashicorp/aws" version = "~> 5.0" 

} 

azurerm = { 

source = "hashicorp/azurerm" version = "=3.45.0" 

} 

}

backend "s3" { bucket = "my-terraform-state" key = "prod/terraform.tfstate" region = "us-east-1" } }

Note: Only constents only store in terraform block. Resources,input and output variable not allowed in terraform block

🔹 Operators
1. =

👉 Exactly this version

version = "= 3.5.0"


Only 3.5.0 will be used.

If provider updates to 3.6.0, Terraform won’t use it.

2. !=

👉 Not equal to this version

version = "!= 3.5.0"


Any version except 3.5.0.

3. <, >, <=, >=

👉 Comparison operators

version = ">= 3.0.0"


Any version 3.0.0 or higher.

version = "< 4.0.0"


Any version below 4.0.0.

4. ~> (Pessimistic constraint)

👉 Means approximately this version.

Example:

version = "~> 3.0"


Allows ≥ 3.0.0 but < 4.0.0

i.e., Terraform can use 3.1.0, 3.5.9, etc., but not 4.0.0.

Another example:

version = "~> 3.5"


Allows ≥ 3.5.0 but < 3.6.0

## Author

Gowtham S / DevOps Engineer




