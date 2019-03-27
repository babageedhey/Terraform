variable "AWS_ACCESS_KEY" {default = ""}
variable "AWS_SECRET_KEY" {default = ""}
variable "AWS_REGION" {
  default = "us-west-2"
}
variable "AMIS" {
  type = "map"
  default = {
    us-east-2 = "ami-ff48629a"
    us-west-2 = "ami-03266811469b418ca"
    us-west-2 = "ami-005bdb005fb00e791"
  }
}

