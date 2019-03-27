//instance.tf

resource "aws_instance" "example" {
  ami           = "ami-005bdb005fb00e791"
  instance_type = "t2.micro"
  key_name = "new_machine"

  security_groups = ["${aws_security_group.allow_rdp.name}"]

  tags {
     Name = "Lab2"
  }

}
