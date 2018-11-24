resource "aws_eip" "ghe" {
  count    = 2
  instance = "${element(aws_instance.ghe.*.id, count.index)}"
  vpc      = true
}
