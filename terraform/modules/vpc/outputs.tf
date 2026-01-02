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

output "private_subnet_ids" {
  description = "プライベートサブネットのIDリスト"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  value       = aws_internet_gateway.main.id
}

output "private_route_table_id" {
  description = "プライベートルートテーブルのID"
  value       = aws_route_table.private.id
}