locals {
  env_tag      = "${element(split(".", var.ghe_hostname), 0)}"
  ghe_password = "${data.aws_ssm_parameter.ghe_password.value}"
}

resource "aws_instance" "ghe" {
  count                  = 2
  ami                    = "${data.aws_ami.ghe.id}"
  subnet_id              = "${element(var.subnet_ids, count.index)}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.ghe.id}"]

  ebs_block_device {
    device_name = "/dev/xvdg"
    volume_type = "gp2"
    volume_size = "${var.data_volume_size}"
  }

  tags = {
    Name = "${local.env_tag}-${format("%01d", count.index + 0)}"
  }
}

data "aws_ssm_parameter" "ghe_password" {
  name = "/${local.env_tag}/ghe_password"
}

resource "null_resource" "ghe_config" {
  // Check that GHE is ready to take API requests
  provisioner "local-exec" {
    command = "until [ $(curl -skL 'https://${aws_eip.ghe.0.public_ip}:8443/setup/start' | grep -o 'Setup GitHub Enterprise' | wc -l) -eq 1 ]; do echo 'API not ready. Sleeping for 10 seconds...' && sleep 10; done"
  }

  // Upload license and set Management Console password
  provisioner "local-exec" {
    command = "sleep 5 && curl -skL -X POST 'https://${aws_eip.ghe.0.public_ip}:8443/setup/api/start' -F license=@${var.ghe_license} -F 'password=${local.ghe_password}'"
  }

  // Upload JSON configuration
  provisioner "local-exec" {
    command = "sleep 10 && curl -skL -X PUT 'https://api_key:${local.ghe_password}@${aws_eip.ghe.0.public_ip}:8443/setup/api/settings' --data-urlencode \"settings=`cat ${var.ghe_settings}`\""
  }

  // Start configuring
  provisioner "local-exec" {
    command = "sleep 10 && curl -skL -X POST 'https://api_key:${local.ghe_password}@${aws_eip.ghe.0.public_ip}:8443/setup/api/configure'"
  }
}
