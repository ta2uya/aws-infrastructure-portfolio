output "vpc_id" {
  description = "作成されたVPCのID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "パブリックサブネットのID"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "プライベートサブネットのID"
  value       = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  description = "ALBのDNS名"
  value       = module.alb.alb_dns_name
}

output "ec2_private_ips" {
  description = "EC2のプライベートIP"
  value       = module.ec2.private_ips
}

output "rds_endpoint" {
  description = "RDSエンドポイント"
  value       = module.rds.db_endpoint
}

output "rds_db_name" {
  description = "RDSデータベース名"
  value       = module.rds.db_name
}