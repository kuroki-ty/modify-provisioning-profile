### certディレクトリ
- 証明書を格納するためのディレクトリ
  - Apple Member CenterのCertificatesから"/profile/sample.mobileprovision"に紐付いている証明書をdownloadし、キーチェーンアクセスに登録する
  - modify-ios-provisioning-profile.sh内ではファイル名ではなく証明書名を使用するため、必ずしもcertディレクトリ内に証明書ファイルは存在していなくても良い
  - 他人に本スクリプトを配布する際にp12形式で格納しておくことを推奨する
