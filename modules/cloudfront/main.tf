resource "aws_cloudfront_distribution" "static-www" {
    enabled = true

    origin {
        domain_name = "${var.static-www-bucket-regional_domain_name}"
        origin_id = "${var.static-www-bucket-id}"
        s3_origin_config {
          origin_access_identity = aws_cloudfront_origin_access_identity.static-www.cloudfront_access_identity_path
        }
    }

    default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods = [ "GET", "HEAD" ]
        cached_methods = [ "GET", "HEAD" ]
        target_origin_id = "${var.static-www-bucket-id}"
        
        forwarded_values {
            query_string = false

            cookies {
              forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl = 0
        default_ttl = 3600
        max_ttl = 86400
    }

    restrictions {
      geo_restriction {
          restriction_type = "whitelist"
          locations = [ "JP" ]
      }
    }
    viewer_certificate {
        cloudfront_default_certificate = true
    }
}

resource "aws_cloudfront_origin_access_identity" "static-www" {}
