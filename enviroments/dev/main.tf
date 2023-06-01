provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region =  "${var.aws_region}"
}

module "aws_s3" {
    source = "../../modules/s3"
    
    #Set Palamater
    enviroments                     = "${var.enviroments}"
    cdn-access-identity-iam_arn     = "${module.aws_cloudfront.cdn-access-identity-iam_arn}"
}

module "aws_cloudfront" {
    source = "../../modules/cloudfront"

    #Set Palamater
    enviroments                            = "${var.enviroments}"
    static-www-bucket-id                   = "${module.aws_s3.static-www-bucket-id}"
    static-www-bucket-regional_domain_name = "${module.aws_s3.static-www-bucket-regional_domain_name}"
}