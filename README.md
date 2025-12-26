## AWS Infrastructure Portfolio
This is a collection of Infrastructure as Code (IaC) samples for AWS environments.
The same configuration is implemented in both Terraform and CloudFormation, allowing you to compare and learn.  

AWS環境のInfrastructure as Code（IaC）サンプル集です。  
TerraformとCloudFormationの両方で同じ構成を実装し、比較・学習できるようにしています。

## 構成図

![Architecture](docs/architecture.png)

※ 構成図は準備中です

## 対象AWS構成

Webアプリケーション向けの基本的なAWS構成を実装しています。

| リソース | 説明 |
|----------|------|
| VPC | パブリック/プライベートサブネット構成 |
| ALB | Application Load Balancer |
| EC2 | Web/APサーバー（プライベートサブネット配置） |
| RDS | データベース（PostgreSQL/MySQL）（プライベートサブネット配置） |
| CloudFront | CDN |
| WAF | Webアプリケーションファイアウォール |

## ディレクトリ構成
```
.
├── terraform/           # Terraformコード
│   ├── environments/    # 環境別設定（dev/prod）
│   └── modules/         # 再利用可能なモジュール
├── cloudformation/      # CloudFormationテンプレート
└── docs/                # ドキュメント・構成図
```

## 使用技術

- **Terraform** v1.5+
- **AWS CloudFormation**
- **AWS CLI** v2

## 設計ポイント

- EC2（Web/AP）はプライベートサブネットに配置（セキュリティ考慮）
- ALB経由でのアクセスに限定
- 環境別（dev/prod）に設定を分離
- モジュール化による再利用性の確保

## 作者

- GitHub: [@ta2uya](https://github.com/ta2uya)

## ライセンス

MIT License