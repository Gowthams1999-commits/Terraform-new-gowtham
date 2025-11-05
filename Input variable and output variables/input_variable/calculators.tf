locals {

  a = 2 * 2
  b = 2 / 2
  c = 2 + 2
  d = 2 - 2
  f = 2 % 2


}

locals {

  result = {

    a = local.a
    b = local.b
    c = local.c
    d = local.d
    f = local.f

  }
}


output "local_result" {

  value = local.result

}
