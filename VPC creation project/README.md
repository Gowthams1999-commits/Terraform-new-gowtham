# VPC Creation with Terraform

## Implementation Plan:

1. Create a VPC
2. Create an Internet Gateway (IGW)
Attach IGW to the VPC for internet access.
3. Create Subnet(s)
4. Create a Route Table
5. Associate Route Table with Subnet
Public subnet → route via IGW.
6. Create a Security Group
Allow inbound traffic (e.g., SSH 22, HTTP 80).
Allow outbound traffic to internet.
7. Launch an EC2 Instance
Place instance in the public subnet.
8. Attach the security group.
9. Destroy EC2 Instance (when testing is done)
Run terraform destroy to remove resources.

## 🔹 Common Terraform Meta-Arguments
1. count

Creates multiple copies of a resource.

Example: create 3 EC2 instances.

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
  count         = 3
}


👉 aws_instance.example[0], aws_instance.example[1], etc.

2. for_each

Creates multiple resources based on a map or set.

Example: create multiple S3 buckets from a list.

resource "aws_s3_bucket" "example" {
  for_each = toset(["dev", "test", "prod"])
  bucket   = "my-bucket-${each.key}"
}


👉 Easier than count when you want named resources.

3. depends_on

Explicitly declare dependency between resources.

Example: Ensure EC2 starts after Security Group is created.

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  depends_on = [aws_security_group.sg]
}

4. provider

Select which provider instance to use (when you have multiple).

Example: Deploy resources in two AWS regions.

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_instance" "east" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}

resource "aws_instance" "west" {
  provider      = aws.west
  ami           = "ami-654321"
  instance_type = "t2.micro"
}

5. lifecycle

Control resource behavior.

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  lifecycle {
    prevent_destroy = true   # Protect from accidental deletion
    ignore_changes  = [tags] # Ignore tag updates
    create_before_destroy = true # For zero-downtime replacement
  }
}

6. provisioner (less recommended)

Runs scripts/commands on resources after creation.

Example: install software via remote exec.

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx"
    ]
  }
}


👉 ⚠️ Not best practice — instead, prefer user_data or configuration management (Ansible, etc.).

✅ Summary of commonly used meta-arguments:

count → multiple resources

for_each → map/set-based resources

depends_on → explicit dependency

provider → choose provider alias

lifecycle → manage resource lifecycle

provisioner → post-creation scripts (not recommended in production)

# Local is terraform

🔹 What is a locals block in Terraform?

A locals block in Terraform is used to define local variables.

These are temporary named values that you can reuse in your Terraform configuration.

They help in avoiding repetition and make code more readable & maintainable.

✅ Syntax
locals {
  app_name   = "myapp"
  environment = "dev"
  common_tags = {
    Owner   = "DevOpsTeam"
    Project = "TerraformDemo"
  }
}

🔹 How to use locals

You reference locals using:

local.<NAME>

Example 1: Using locals in resource
resource "aws_s3_bucket" "example" {
  bucket = "${local.app_name}-${local.environment}"
  tags   = local.common_tags
}


👉 The bucket name will be: myapp-dev
👉 Tags will be applied from common_tags.
