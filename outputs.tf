output "ec2_public_ip" {
  description = "Public IP of the EC2 instance."
  value       = module.compute.public_ip
}

output "s3_bucket_name" {
  description = "S3 bucket name."
  value       = module.storage.bucket_name
}

output "vpc_id" {
  description = "VPC ID."
  value       = module.network.vpc_id
}
