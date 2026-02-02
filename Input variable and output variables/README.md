# Input, output and locals

## Input variable (Arguments)

🧩 Inputs

Inputs are the variables that make your Terraform module or configuration customizable.
They allow users to pass in values like region, instance type, or environment without modifying the main .tf files.

Example: 
* ami_id
* instance_type
* Key_name

 ## output variable

 📤 Outputs (Attributes)

Outputs let Terraform display important information after deployment —
like IP addresses, resource IDs, or URLs — which can be used by other modules or scripts.

| Name                 | Description                           |
| -------------------- | ------------------------------------- |
| `instance_id`        | ID of the created EC2 instance        |
| `instance_public_ip` | Public IP address of the EC2 instance |
| `vpc_id`             | ID of the created VPC                 |

## Locals

🧮 Locals

Locals are used to define local variables — calculated or reused values within your Terraform configuration.
They make your code cleaner and more maintainable.

| Name            | Description                          |
| --------------- | ------------------------------------ |
| `common_tags`   | Common tags applied to all resources |
| `instance_name` | Computed name for EC2 instances      |


## Author

Gowtham S / DevOps Engineer
