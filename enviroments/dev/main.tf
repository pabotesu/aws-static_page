provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region =  "${var.aws_region}"
}

module "aws_vpc" {
    source = "../../modules/s3"
    
    #Set Palamater
    enviroments       = "${var.enviroments}"
}