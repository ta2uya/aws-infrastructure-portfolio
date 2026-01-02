variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDR"
  type        = string
}

variable "subnet_ids" {
  description = "エンドポイントを配置するサブネットID（プライベートサブネット）"
  type        = list(string)
}

variable "route_table_ids" {
  description = "S3エンドポイント用ルートテーブルID"
  type        = list(string)
}

variable "aws_region" {
  description = "AWSリージョン"
  type        = string
  default     = "ap-northeast-1"
}