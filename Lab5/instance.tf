//instance.tf

resource "aws_instance" "master" {
  count                 = 1
  ami                   = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type         = "t2.micro"
  subnet_id             = "subnet-17443139"
  key_name              = "${aws_key_pair.mykey.key_name}"
  private_ip            = "${lookup(var.instance_ips, count.index)}"
  root_block_device {
  volume_type = "gp2"
  volume_size = 20
}
  connection {
    type        = "ssh"
    agent       = "false"
    timeout     = "30s"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"

  }

  provisioner "file" {
    source      = "master-run.sh"
    destination = "/tmp/run.sh"
  }

  provisioner "file" {
    source      = "stack.yml"
    destination = "/tmp/stack.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/run.sh",
      "/tmp/run.sh",
    ]
  }

  tags = {
    Name = "Swarm Leader"
  }
}

resource "aws_instance" "slave" {
  count                 = 2
  ami                   = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type         = "t2.micro"
  subnet_id             = "subnet-17443139"
  key_name              = "${aws_key_pair.mykey.key_name}"
  private_ip            = "${lookup(var.instance_ips, count.index + 1)}"
  root_block_device {
  volume_type = "gp2"
  volume_size = 20
}
  connection {
    type        = "ssh"
    agent       = "false"
    timeout     = "30s"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"

  }
  provisioner "file" {
    source      = "slave-run.sh"
    destination = "/tmp/run.sh"
  }
  provisioner "file" {
    source = "mykey"
    destination = "/home/ubuntu/.ssh/mykey"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/run.sh",
      "/tmp/run.sh",
    ]
  }

tags = {
    Name = "Swarm Manager ${count.index + 1}"
  }
}