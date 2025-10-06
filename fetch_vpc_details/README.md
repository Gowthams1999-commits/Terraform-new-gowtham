# Collect VPC Details from a Manually Created VPC

Log in to the AWS Management Console and create a VPC manually.
Make sure to add tags (for example, a Name tag like my-manual-vpc) so Terraform can easily identify it.

Create a Terraform configuration file to fetch the VPC ID using a data source and use that information to create a subnet within the same VPC.
