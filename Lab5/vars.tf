variable "instance_ips" {
  default = {

    "0" = "172.31.80.10"
    "1" = "172.31.80.20"
    "2" = "172.31.80.30"


  }
}

variable "AWS_ACCESS_KEY" {default = "AKIAIVUTFOXVLOOUTPLQ"}
variable "AWS_SECRET_KEY" {default = "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"}
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

