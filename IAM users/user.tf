
## user details
variable "user_details" {

type = list(string)
default = ["gowtham", "somu", "appu"]

}


## create a reources
resource "aws_iam_user" "user" {

for_each = toset(var.user_details)
name = each.key

tags = {


Managed_by = "Terraform"

}
}

## Create a console password

resource "aws_iam_user_login_profile" "login_password" {

for_each = aws_iam_user.user
user = each.value.name
password_reset_required = true


}
