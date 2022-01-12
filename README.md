# newrelic-metric-stream-sample

NewRelic との AWS 連携において IAM Role の作成と Metric Steram で NewRelic に対してメトリクスを送るための設定を作成するリポジトリです。

## Install Tool

- AWS Profile などの設定は事前にされている前提でおこないます。
  - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html
  
1. tfenv 経由で Terraform をインストール

```shell
 brew install tfenv
```

.terraform-version によってその Terraform プロジェクトで使用される Terraform のバージョンになります。

通常であれば .terraform-version に設定している値がローカルになければ tfenv が自動でインストールしてくれますがもしインストールされなければ tfenv 経由で今回使用するバージョンのインストールを行ってください。

```shell
 tfenv install 1.1.3
 
 tfenv global 1.1.3
```

## IAM Role を作成

1. 最初に IAM Role を作成するので iam ディレクトリに移動します。

```shell
 cd iam
```

2. terraform init でセットアップ

```shell
 terraform init
```

3. terraform.tfvars を作成

```shell
 cp terraform.tfvars.sample terraform.tfvars
```

以下のように編集

```terraform
 newrelic_account_id     = "your newrelic account id"
 another_aws_account_id = "another aws account id"
```

4. terraform plan で作成されるリソースを確認

```shell
 terraform plan
```

5. terraform apply で作成

```shell
 terraform apply
```

途中で実行してもいいかの確認がありますが yes と入力してください。
Apply complete! がでてきたら成功です。

aws コンソールで作成された IAM Role の arn をコピーしてください。
下記の aws cli でも取得可能です。
```shell
 aws iam get-role --role-name NewRelicInfrastructure-Integrations | jq '.Role.Arn'
```

取得した arn を NewRelic One の AWS 連携画面の Step5 で入力します。

## MetricStream の作成

1. metric_stream のディレクトリに移動

```shell
 cd metric_stream
```

2. terraform をセットアップ

```shell
 terraform init
```

3. 環境変数の設定

terraform.tfvars を作成し環境変数を設定
```shell
 cp terraform.tfvars.sample terraform.tfvars
```

NewRelic のライセンスキー と s3 の bucket を一意なものにするために何かしらの prefix を当てるために環境変数を設定。

```terraform
newrelic_license_key = "NewRelic License Key"
bucket_prefix        = "bucket-prefix"
```


4. terraform plan で作成されるリソースの確認

```shell
 terraform plan
```

5. terraform apply で作成

```shell
 terraform apply
```

リソースが作成されたら数分間待って NewRelic に Metrics が転送されていれば成功です。
