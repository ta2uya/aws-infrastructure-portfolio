output "db_endpoint" {
  description = "RDSエンドポイント"
  value       = aws_db_instance.main.endpoint
}

output "db_address" {
  description = "RDSアドレス（ホスト名）"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "RDSポート"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "データベース名"
  value       = aws_db_instance.main.db_name
}