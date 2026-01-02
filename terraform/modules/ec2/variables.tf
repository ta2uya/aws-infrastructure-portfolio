variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名"
  type        = string
}

variable "instance_type" {
  description = "EC2インスタンスタイプ"
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "EC2インスタンス数"
  type        = number
  default     = 2
}

variable "subnet_ids" {
  description = "EC2を配置するサブネットIDのリスト"
  type        = list(string)
}

variable "security_group_id" {
  description = "EC2用セキュリティグループID"
  type        = string
}