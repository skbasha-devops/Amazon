resource "local_file" res1 {
filename = var.f1
content - var.f1
}
variable f1 {
type = string
default = "abc.txt"
}
