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
