output "ssm_endpoint_id" {
  description = "SSMエンドポイントID"
  value       = aws_vpc_endpoint.ssm.id
}

output "s3_endpoint_id" {
  description = "S3エンドポイントID"
  value       = aws_vpc_endpoint.s3.id
}

output "vpc_endpoint_security_group_id" {
  description = "VPCエンドポイント用セキュリティグループID"
  value       = aws_security_group.vpc_endpoint.id
}