output "cloudtrail_name" {
  value = aws_cloudtrail.this.name
}

output "cloudtrail_arn" {
  value = aws_cloudtrail.this.arn
}

output "audit_bucket_name" {
  value = aws_s3_bucket.cloudtrail.bucket
}

output "audit_bucket_arn" {
  value = aws_s3_bucket.cloudtrail.arn
}

output "guardduty_detector_id" {
  value = aws_guardduty_detector.this.id
}

output "guardduty_detector_arn" {
  value = aws_guardduty_detector.this.arn
}
