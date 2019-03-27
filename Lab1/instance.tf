//instance.tf

provider "aws" {
  #access_key = "ACCESS_KEY_HERE"
  #secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "test" {
  ami           = "ami-0ac019f4fcb7cb7e6"
  instance_type = "t2.micro"
}
