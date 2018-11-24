resource "aws_route53_zone" "ghe" {
  name = "${var.ghe_hostname}"
}

resource "aws_route53_record" "ghe_hostname" {
  zone_id = "${aws_route53_zone.ghe.zone_id}"
  name    = "${var.ghe_hostname}"
  type    = "A"
  ttl     = "300"
  records = ["${var.primary == "0" ? aws_eip.ghe.0.public_ip : aws_eip.ghe.1.public_ip}"]
}

resource "aws_route53_record" "ghe_wildcard" {
  zone_id = "${aws_route53_zone.ghe.zone_id}"
  name    = "*.${var.ghe_hostname}"
  type    = "A"
  ttl     = "300"
  records = ["${var.primary == "0" ? aws_eip.ghe.0.public_ip : aws_eip.ghe.1.public_ip}"]
}
