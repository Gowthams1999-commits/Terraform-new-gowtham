variable "list_number" {

  type    = list(number)
  default = ["1", "2", "3"]

}


locals {

  double_number = [for i in var.list_number : i * 2]


}

output "double_number" {


  value = local.double_number

}


locals {


even_number = [for even in var.list_number : even if even % 2 == 0]

}

output "even_number" {


value = local.even_number

}
