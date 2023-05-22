output "static-www-bucket-id" {
  value = ["${aws_s3_bucket.static-www-bucket.id}"]
}