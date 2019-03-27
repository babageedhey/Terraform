resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow traffic for ports"

  vpc_id      = "${aws_vpc.test-env.id}"

  ingress {

    from_port   = 22
    to_port     = 22
    protocol =   "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port    = 80
    protocol   = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }
// Terraform removes the default rule

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

}
