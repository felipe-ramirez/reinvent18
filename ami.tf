data "aws_ami" "ghe" {
  filter {
    name   = "name"
    values = ["GitHub Enterprise ${var.ghe_version}"]
  }

  owners = ["895557238572"]
}
