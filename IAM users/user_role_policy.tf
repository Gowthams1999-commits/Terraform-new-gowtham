
## users variable
variable "users_info" {

  type    = list(string)
  default = ["gowtham", "shabnam", "aparna"]


}


# users creation resource block
resource "aws_iam_user" "users" {


  for_each = toset(var.users_info)
  name     = each.key

  tags = {

    Created_by = "terraform"

  }
}


# Roles variable
variable "roles_details" {

  type = map(object({

    description = string

    policy_arn = string


  }))

  default = {

    dev_roles = {

      description = "Developer roles"
      policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

    }

    operation_roles = {


      description = "Operation roles"
      policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"


    }
  }
}



resource "aws_iam_role" "users_roles" {


  for_each    = var.roles_details
  name        = each.key
  description = each.value.description

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
      },
    ]
  })



}


# Roles creation resource block
resource "aws_iam_role_policy_attachment" "test-attach" {
  for_each   = var.roles_details
  role       = aws_iam_role.users_roles[each.key].name
  policy_arn = each.value.policy_arn
}



output "user" {


  value = [for u in values(aws_iam_user.users) : u.name]

}
