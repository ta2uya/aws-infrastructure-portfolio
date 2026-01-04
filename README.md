# AWS Infrastructure Portfolio

AWS環境のInfrastructure as Code（IaC）サンプル集  
TerraformとCloudFormationの両方で同じ3層サブネット構成を実装

## 構成図
```
┌─────────────────────────────────────────────────────────────┐
│ VPC (10.0.0.0/16)                                           │
│                                                             │
│  ┌─────────────────────┐    ┌─────────────────────┐         │
│  │ Public Subnet (1a)  │    │ Public Subnet (1c)  │         │
│  │ 10.0.1.0/24         │    │ 10.0.2.0/24         │         │
│  │       ┌─────┐       │    │                     │         │
│  │       │ ALB │◄──────┼────┼─── Internet         │         │
│  │       └──┬──┘       │    │                     │         │
│  └──────────┼──────────┘    └─────────────────────┘         │
│             │                                               │
│             ▼                                               │
│  ┌─────────────────────┐    ┌─────────────────────┐         │
│  │ Private_WebAP (1a)  │    │ Private_WebAP (1c)  │         │
│  │ 10.0.11.0/24        │    │ 10.0.12.0/24        │         │
│  │       ┌─────┐       │    │       ┌─────┐       │         │
│  │       │ EC2 │       │    │       │ EC2 │       │         │
│  │       └──┬──┘       │    │       └──┬──┘       │         │
│  │          │          │    │          │          │         │
│  │  ┌───────────────┐  │    │                     │         │
│  │  │ VPC Endpoints │  │    │                     │         │
│  │  │ (SSM/S3)      │  │    │                     │         │
│  │  └───────────────┘  │    │                     │         │
│  └──────────┼──────────┘    └──────────┼──────────┘         │
│             │                          │                    │
│             ▼                          ▼                    │
│  ┌─────────────────────┐    ┌─────────────────────┐         │
│  │ Private_DB (1a)     │    │ Private_DB (1c)     │         │
│  │ 10.0.21.0/24        │    │ 10.0.22.0/24        │         │
│  │       ┌─────┐       │    │                     │         │
│  │       │ RDS │       │    │                     │         │
│  │       └─────┘       │    │                     │         │
│  └─────────────────────┘    └─────────────────────┘         │
└─────────────────────────────────────────────────────────────┘
```

## 対象AWSリソース

| リソース | 説明 |
|----------|------|
| VPC | 3層サブネット構成（Public / WebAP / DB） |
| ALB | Application Load Balancer（パブリックサブネット配置） |
| EC2 | Web/APサーバー（プライベートサブネット配置） |
| RDS | PostgreSQL（DBサブネット配置） |
| VPC Endpoints | SSM/S3エンドポイント（NAT Gateway不要化） |
| Security Groups | ALB/EC2/RDS/VPCエンドポイント用 |

## ディレクトリ構成
```
.
├── terraform/              # Terraformコード
│   ├── environments/       # 環境別設定
│   │   └── dev/
│   └── modules/            # 再利用可能なモジュール
│       ├── vpc/
│       ├── vpc_endpoints/
│       ├── security_group/
│       ├── ec2/
│       ├── alb/
│       └── rds/
├── cloudformation/         # CloudFormationテンプレート
│   ├── vpc.yaml
│   ├── security-group.yaml
│   ├── vpc-endpoints.yaml
│   ├── ec2.yaml
│   ├── alb.yaml
│   ├── rds.yaml
│   └── README.md
└── docs/                   # ドキュメント
```

## 使用技術

- **Terraform** v1.0+
- **AWS CloudFormation**
- **AWS CLI** v2

## 設計ポイント

### セキュリティ
- EC2はプライベートサブネットに配置し、ALB経由のアクセスに限定
- RDSはDBサブネットに配置し、EC2からのみアクセス可能
- VPCエンドポイント経由でSSM/S3に接続（NAT Gateway不要）

### 可用性
- マルチAZ構成（2つのアベイラビリティゾーンにサブネット・EC2を配置）
- ALBによる負荷分散
- RDSはシングルAZ（本番環境ではマルチAZ推奨）

### 運用性
- Session Manager経由でEC2に接続（踏み台サーバー不要、SSHポート開放不要）
- 環境別（dev/staging/prod）に設定を分離
- モジュール化による再利用性の確保

## Terraformクイックスタート
```bash
# 環境ディレクトリに移動
cd terraform/environments/dev

# 初期化
terraform init

# 実行計画確認
terraform plan

# デプロイ
terraform apply

# 削除
terraform destroy
```

## CloudFormationクイックスタート

詳細は [cloudformation/README.md](cloudformation/README.md) を参照

## 作者

- GitHub: [@ta2uya](https://github.com/ta2uya)

## ライセンス

MIT License