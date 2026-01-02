variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名"
  type        = string
}

variable "subnet_ids" {
  description = "RDSを配置するサブネットIDのリスト（プライベートサブネット）"
  type        = list(string)
}

variable "security_group_id" {
  description = "RDS用セキュリティグループID"
  type        = string
}

variable "instance_class" {
  description = "RDSインスタンスクラス"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "割り当てストレージ（GB）"
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "最大割り当てストレージ（GB）- オートスケーリング上限"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "データベース名"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "マスターユーザー名"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "マスターパスワード"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "マルチAZ配置"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "バックアップ保持期間（日）"
  type        = number
  default     = 7
}