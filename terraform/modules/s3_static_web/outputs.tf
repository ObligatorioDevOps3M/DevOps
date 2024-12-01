output "website_url" {
  value       = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "URL of the static website hosted on S3"
}

output "bucket_name" {
  value       = aws_s3_bucket_website_configuration.static_website.bucket
  description = "S3 bucket name."
}