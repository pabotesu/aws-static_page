resource "aws_s3_bucket" "static-www-bucket" {
    bucket_prefix = "www.${var.enviroments}.static-bucket"
}

/*acl [private]*/
resource "aws_s3_bucket_ownership_controls" "static-www-bucket-own" {
    bucket = aws_s3_bucket.static-www-bucket.id
    rule {
     object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_acl" "static-www-bucket-acl" {
    depends_on = [aws_s3_bucket_ownership_controls.static-www-bucket-own]
    bucket = aws_s3_bucket.static-www-bucket.id
    acl =  "private"
}
/*acl [private]*/

/*static-website setting*/
resource "aws_s3_bucket_website_configuration" "static-www-bucket-websiteconf" {
  bucket = aws_s3_bucket.static-www-bucket.id

    index_document {
     suffix = "index.html"
    }

    error_document {
     key = "error.html"
    }

    routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}
/*static-website setting*/

/*iam policy for static website bucket*/

/* -> iam policy for static website bucket data <- */

data "aws_iam_policy_document" "static-www-bucket" {
    statement {
    sid = "Allow CloudFront"
    effect = "Allow"
    principals {
        type = "AWS"
        identifiers = ["${var.cdn-access-identity-iam_arn}"]
    }
    actions = [
        "s3:GetObject"
    ]

    resources = [
        "${aws_s3_bucket.static-www-bucket.arn}/*"
    ]
  }
}

/* -> iam policy for static website bucket data <- */

resource "aws_s3_bucket_policy" "static-www-bucket-policy" {
    bucket = aws_s3_bucket.static-www-bucket.id
    policy = data.aws_iam_policy_document.static-www-bucket.json
}

/*iam policy for static website bucket*/
