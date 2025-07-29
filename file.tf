resource "local_file" "res1" {
  filename = var.f1
  content  = var.f1  # CORRECT: using equals sign
}
variable f1 {
type = string
default = "abc.txt"
}
