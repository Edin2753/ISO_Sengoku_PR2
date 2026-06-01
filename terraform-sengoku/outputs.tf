output "alb_dns" {
  value = aws_lb.main.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "s3_bucket_name" {
  value = aws_s3_bucket.static.bucket
}

output "s3_base_url" {
  value = "https://${aws_s3_bucket.static.bucket}.s3.${var.aws_region}.amazonaws.com/images"
}

output "ec2_1_public_ip" {
  value = aws_instance.ec2_1.public_ip
}

output "ec2_2_public_ip" {
  value = aws_instance.ec2_2.public_ip
}
