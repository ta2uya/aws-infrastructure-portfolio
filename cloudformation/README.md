# CloudFormation Templates

AWS CloudFormationを使用した3層サブネットアーキテクチャのテンプレート集

## 構成概要

| テンプレート | 説明 |
|--------------|------|
| vpc.yaml | VPC、サブネット（Public/WebAP/DB）、ルートテーブル |
| security-group.yaml | ALB/EC2/RDS/VPCエンドポイント用セキュリティグループ |
| vpc-endpoints.yaml | SSM/S3用VPCエンドポイント |
| ec2.yaml | EC2インスタンス、IAMロール |
| alb.yaml | Application Load Balancer、ターゲットグループ |
| rds.yaml | RDS PostgreSQL |

## デプロイ順序

依存関係を考慮し、以下の順序でデプロイすること

1. vpc.yaml
2. security-group.yaml
3. vpc-endpoints.yaml
4. ec2.yaml
5. alb.yaml
6. rds.yaml

## デプロイ方法

### AWS CLIを使用する場合
1.VPC
```
aws cloudformation create-stack \
  --stack-name portfolio-dev-vpc \
  --template-body file://vpc.yaml \
  --parameters ParameterKey=ProjectName,ParameterValue=portfolio \
               ParameterKey=Environment,ParameterValue=dev
```

### スタック作成完了まで待機
```
aws cloudformation wait stack-create-complete --stack-name portfolio-dev-vpc
```

2.Security Group
```
aws cloudformation create-stack \
  --stack-name portfolio-dev-sg \
  --template-body file://security-group.yaml \
  --parameters ParameterKey=ProjectName,ParameterValue=portfolio \
               ParameterKey=Environment,ParameterValue=dev

aws cloudformation wait stack-create-complete --stack-name portfolio-dev-sg
```


3.VPC Endpoints
```
aws cloudformation create-stack \
  --stack-name portfolio-dev-vpce \
  --template-body file://vpc-endpoints.yaml \
  --parameters ParameterKey=ProjectName,ParameterValue=portfolio \
               ParameterKey=Environment,ParameterValue=dev

aws cloudformation wait stack-create-complete --stack-name portfolio-dev-vpce
```

4.EC2
```
aws cloudformation create-stack \
  --stack-name portfolio-dev-ec2 \
  --template-body file://ec2.yaml \
  --parameters ParameterKey=ProjectName,ParameterValue=portfolio \
               ParameterKey=Environment,ParameterValue=dev \
  --capabilities CAPABILITY_NAMED_IAM

aws cloudformation wait stack-create-complete --stack-name portfolio-dev-ec2
```

5.ALB
```
aws cloudformation create-stack \
  --stack-name portfolio-dev-alb \
  --template-body file://alb.yaml \
  --parameters ParameterKey=ProjectName,ParameterValue=portfolio \
               ParameterKey=Environment,ParameterValue=dev

aws cloudformation wait stack-create-complete --stack-name portfolio-dev-alb
```

6.RDS
```
aws cloudformation create-stack \
  --stack-name portfolio-dev-rds \
  --template-body file://rds.yaml \
  --parameters ParameterKey=ProjectName,ParameterValue=portfolio \
               ParameterKey=Environment,ParameterValue=dev \
               ParameterKey=DBPassword,ParameterValue=<PASSWORD>
aws cloudformation wait stack-create-complete --stack-name portfolio-dev-rds
```

### AWSコンソールを使用する場合

1. CloudFormation → 「スタックの作成」
2. 「テンプレートファイルのアップロード」を選択
3. 各yamlファイルをアップロード
4. パラメータを入力
5. 「スタックの作成」をクリック

## 削除方法
デプロイとは逆の順で削除
```
aws cloudformation delete-stack --stack-name portfolio-dev-rds
aws cloudformation wait stack-delete-complete --stack-name portfolio-dev-rds

aws cloudformation delete-stack --stack-name portfolio-dev-alb
aws cloudformation wait stack-delete-complete --stack-name portfolio-dev-alb

aws cloudformation delete-stack --stack-name portfolio-dev-ec2
aws cloudformation wait stack-delete-complete --stack-name portfolio-dev-ec2

aws cloudformation delete-stack --stack-name portfolio-dev-vpce
aws cloudformation wait stack-delete-complete --stack-name portfolio-dev-vpce

aws cloudformation delete-stack --stack-name portfolio-dev-sg
aws cloudformation wait stack-delete-complete --stack-name portfolio-dev-sg

aws cloudformation delete-stack --stack-name portfolio-dev-vpc
aws cloudformation wait stack-delete-complete --stack-name portfolio-dev-vpc
```

## 備考：本番環境での推奨事項
本テンプレートは演習用のため、本番環境では下記の変更を推奨

| 項目 | 本テンプレート | 本番環境推奨 |
|------|----------------|--------------|
| ドメイン | 未設定 | Route53 + 独自ドメイン |
| 通信プロトコル | HTTP | HTTPS（ACM証明書使用） |
| ネットワーク制御 | Security Groupのみ | Security Group + NACL併用 |
| RDS可用性 | シングルAZ | マルチAZ有効化 |
| RDS削除保護 | 無効 | 有効化 |
| RDS最終スナップショット | スキップ | 取得設定 |
| ログ収集 | 未設定 | CloudWatch Logs、ALBアクセスログ有効化 |
| 監視 | 未設定 | CloudWatch Alarms設定 |