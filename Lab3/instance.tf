//instance.tf

resource "aws_instance" "example" {
  ami           = "ami-005bdb005fb00e791"
  instance_type = "t2.micro"
  key_name = "new_machine"

  security_groups = ["${aws_security_group.terraform_sg.id}"]

  tags {
     Name = "Lab6"
  }
 subnet_id = "${aws_subnet.subnet-uno.id}"
}
