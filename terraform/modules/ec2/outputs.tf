output "instance_ids" {
  description = "EC2インスタンスIDのリスト"
  value       = aws_instance.main[*].id
}

output "private_ips" {
  description = "EC2インスタンスのプライベートIPリスト"
  value       = aws_instance.main[*].private_ip
}