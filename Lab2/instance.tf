//instance.tf

resource "aws_instance" "example" {
  ami           = "ami-0ac019f4fcb7cb7e6"
  instance_type = "t2.micro"
  key_name = "geedhey"


  security_groups = ["${aws_security_group.new_security_group.name}"]

  tags {
     Name = "Lab_2"
  }

}
