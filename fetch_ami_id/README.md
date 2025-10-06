# Fetching AMI ID from Existing Resources Using Data Source in Terraform

In simple terms, think of a data source as a messenger that Terraform sends to fetch information about a pre-existing resource — whether it was created manually or managed by another Terraform configuration — in your cloud provider.

Terraform can then use that fetched information within its own configuration files.

For example, suppose you want to create an EC2 instance in AWS, but it must be launched inside a specific VPC that was created manually in the AWS console.
In that case, Terraform can use a data so
