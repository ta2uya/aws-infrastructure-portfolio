variable "project_name" {
  description = "プロジェクト名"
  type        = string
}

variable "environment" {
  description = "環境名（dev/staging/prod）"
  type        = string
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRリスト"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_webap_subnet_cidrs" {
  description = "プライベートサブネット（WebAP）のCIDRリスト"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  description = "プライベートサブネット（DB）のCIDRリスト"
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "availability_zones" {
  description = "使用するアベイラビリティゾーン"
  type        = list(string)
}