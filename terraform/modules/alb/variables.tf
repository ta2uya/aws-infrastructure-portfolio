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

variable "subnet_ids" {
  description = "ALBを配置するサブネットIDのリスト（パブリックサブネット）"
  type        = list(string)
}

variable "security_group_id" {
  description = "ALB用セキュリティグループID"
  type        = string
}

variable "target_instance_ids" {
  description = "ターゲットグループに登録するEC2インスタンスIDのリスト"
  type        = list(string)
}