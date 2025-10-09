# Variables in Terraform

## Type	               Example
  string	             "us-east-1"
  number	             10
  bool	               true or false
  list(string)	       ["us-east-1", "us-east-2"]
  map(string)	         { env = "dev", owner = "gow" }
  object({...})	       { size = 10, type = "gp2" }
