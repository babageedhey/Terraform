output "master.ip" {
  value = "${aws_instance.master.private_ip}"
}