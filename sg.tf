resource "aws_security_group" "ghe" {
  name        = "ghe-sg"
  vpc_id      = "${var.vpc_id}"
  description = "GitHub Enterprise Appliance Security Group"

  tags = {
    Name      = "${local.env_tag}-appliance SG"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_shell" {
  type              = "ingress"
  from_port         = 122
  to_port           = 122
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_mgmt_console" {
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_simple_git" {
  type              = "ingress"
  from_port         = 9418
  to_port           = 9418
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_ha_tunnel" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_snmp" {
  type              = "ingress"
  from_port         = 161
  to_port           = 161
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_smtp" {
  type              = "ingress"
  from_port         = 25
  to_port           = 25
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe.id}"
}
