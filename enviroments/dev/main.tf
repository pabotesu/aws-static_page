provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region =  "${var.aws_region}"
}

module "aws_s3" {
    source = "../../modules/s3"
    
    #Set Palamater
    enviroments       = "${var.enviroments}"
}

module "aws_cloudfront" {
    source = "../../modules/cloudfront"

    #Set Palamater
    enviroments       = "${var.enviroments}"
    bucket            = "${module.aws_s3.static-www-bucket-id}"
}