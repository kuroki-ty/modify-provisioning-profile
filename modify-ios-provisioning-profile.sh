#!/bin/bash

IPA_FILE=$1
APP_FILE="Payload/$2"
PROVISIONING_PROFILE_FOR_DEBUG=$3
SIGNING_IDENTITY_FOR_DEBUG="証明書名を記載してください"

# Payloadが既にある場合は削除
rm -rf Payload

# ipaファイルをunzipして証明書を書き換えられるようにする
unzip "$IPA_FILE"

# 古いsignatureを消す
rm -rf "$APP_FILE"/_CodeSignature

# プロビジョニングプロファイルを書き換え
cp -p "$PROVISIONING_PROFILE_FOR_DEBUG" "$APP_FILE"/embedded.mobileprovision

# 証明書書き換え
codesign -f -s "$SIGNING_IDENTITY_FOR_DEBUG" --entitlements ./config/entitlements.plist "$APP_FILE"

# 証明書を書き換えたipaファイルに変更
zip -qr ./output/"$IPA_FILE" ./Payload