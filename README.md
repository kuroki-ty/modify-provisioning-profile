# modify-provisioning-profile
- ipa内の署名を書き換えて任意のios端末にバイナリをインストール可能にするスクリプト

# Description
- cert: 証明書格納先
- config: entitlements.plist格納先
  - entitlements.plist: 資格設定ファイル
- output: 書き換えられたipa出力先
- profile: プロビジョニングプロファイル格納先

# 環境
- Mac OS

# Usage
## 初期設定
### 証明書準備
- 書き換えに使用するプロビジョニングプロファイルに紐付いている証明書をApple Member Centerからダウンロードする
- ファイルをダブルクリックし、キーチェーンアクセスに登録する

#### 既にcertディレクトリにsample.p12以外のファイルがある場合
- modify-provisioning-profile/certに入っているp12形式のファイルをダブルクリックする
- パスワードを入力し、OKを押すとキーチェーンアクセスに登録される

### プロビジョニングプロファイル準備
- Apple Member Centerから書き換えに使用するプロビジョニングプロファイルをダウンロードする
- 任意の名前に変更し、profileディレクトリに保存する

```
$ mv /path/to/sample.mobileprovision ./cert/sample.mobileprovision
```

### entitlements.plist準備
- 署名を書きかえるipaファイルを解凍する
- Payloadディレクトリが作成される
- codesignコマンドを実行し、出力結果を参考にサンプルの```entitlements.plist```を修正する
  - ```[TEAM_ID]```と```[APP_BUNDLE_ID]```を適切なものに置き換える

```
$ unzip sample.ipa
$ codesign -d --entitlements - ./Payload/sample.app
$ vim config entitlements.plist
```

### スクリプト修正
- SIGNING_IDENTITY_FOR_DEBUGに登録した証明書名を記載すること

### バイナリ準備
- modify-provisioning-profileディレクトリ直下に署名を書きかえるipaファイルを追加する

```
$ mv /path/to/sample.ipa ./sample.ipa
```

## スクリプト実行
- < >の部分は可変なので適切なものに書き換えること
  - ipa_name: 署名を書き換えるipaファイル名
  - app_name: 署名を書きかえるipaファイル内にあるappファイル名
  - profile_name: profileに保存してあるmobileprovision名

```
$ cd /path/to/modify-provisioning-profile
$ sh modify-ios-provisioning-profile.sh <ipa_name>.ipa <app_name>.app profile/<profile_name>.mobileprovision
```

## 実行結果
- modify-provisioning-profile/outputフォルダに書き換え後のバイナリが格納される
- 手動でios端末にインストールする

## Warning
- cert, config, profileフォルダ内は不変なので、初期設定後は編集しないこと
