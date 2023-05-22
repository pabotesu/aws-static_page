/*provider-settings*/
variable "aws_access_key" {}
variable "aws_secret_key" {}

/*provider-select-region*/
variable "aws_region" {
  default = "ap-northeast-1"
}

/*aws-vpc-settings*/
variable "enviroments" {
  default     = "develop"
}