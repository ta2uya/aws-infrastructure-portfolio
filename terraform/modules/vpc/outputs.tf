output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPCのCIDR"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "パブリックサブネットのIDリスト"
  value       = aws_subnet.public[*].id
}

output "private_webap_subnet_ids" {
  description = "プライベートサブネット（WebAP）のIDリスト"
  value       = aws_subnet.private_webap[*].id
}

output "private_db_subnet_ids" {
  description = "プライベートサブネット（DB）のIDリスト"
  value       = aws_subnet.private_db[*].id
}

output "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  value       = aws_internet_gateway.main.id
}

output "private_webap_route_table_id" {
  description = "プライベートルートテーブル（WebAP）のID"
  value       = aws_route_table.private_webap.id
}

output "private_db_route_table_id" {
  description = "プライベートルートテーブル（DB）のID"
  value       = aws_route_table.private_db.id
}