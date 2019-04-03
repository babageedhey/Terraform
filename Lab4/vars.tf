variable "AWS_ACCESS_KEY" {default="access_key_here"}
variable "AWS_SECRET_KEY" {default="Secret_key_here"}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-1 = "ami-0ac019f4fcb7cb7e6"
    us-west-2 = "ami-0221842fe3a17b6ed"
    eu-west-1 = "ami-06397100adf427136"
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}