# variables 

🟦 1️⃣ string

A simple text value.

🟨 2️⃣ number

Numeric values (integer or float).

🟩 3️⃣ bool

True/False value.

🟪 4️⃣ list(type)

An ordered sequence of values (like an array).

🟧 5️⃣ map(type)

A key-value dictionary.

🟥 6️⃣ object({ ... })

A complex structure with named attributes (like a JSON object).

variable "project_name" {
  type    = string
  default = "myapp"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "instance_ami_map" {
  type = map(string)
  default = {
    us-east-1 = "ami-0abcd1234567890"
    us-west-1 = "ami-0wxyz9876543210"
  }
}

variable "instance_config" {
  type = object({
    instance_type = string
    volume_size   = number
  })
  default = {
    instance_type = "t3.micro"
    volume_size   = 20
  }
}
