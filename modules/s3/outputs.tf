output "static-www-bucket-id" {
  value = "${aws_s3_bucket.static-www-bucket.id}"
}
output "static-www-bucket-regional_domain_name" {
  value = "${aws_s3_bucket.static-www-bucket.bucket_regional_domain_name}"
}