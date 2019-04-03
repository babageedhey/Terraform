resource "aws_security_group" "new_security_group" {
  name        = "new_security_group"
  description = "Allow traffic connetcion to port 22"

  ingress {

    from_port   = 22
    to_port     = 22
    protocol =   "tcp"

    cidr_blocks =  ["0.0.0.0/0"]
  }
}
