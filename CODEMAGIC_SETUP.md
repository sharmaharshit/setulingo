# Codemagic & Android Signing Setup Guide

This guide explains how to build **SetuLingo** (`com.setulingo.app`) into signed Android `.apk` and `.aab` files using **Codemagic** after uploading the source to GitHub.

## 1. Connect GitHub to Codemagic
1. Log in to [Codemagic](https://codemagic.io/) and click **Add application**.
2. Select **GitHub** and choose your `SetuLingo` repository.
3. Select **Flutter App (via codemagic.yaml)** as the configuration source.

## 2. Generate an Android Upload Keystore (Locally)
Run the following command on your local machine (never commit the `.jks` file to Git):
```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Encode the keystore to Base64 for Codemagic:
- **macOS**: `base64 -i upload-keystore.jks | pbcopy`
- **Linux**: `base64 -w 0 upload-keystore.jks`
- **Windows (PowerShell)**: `[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks"))`

## 3. Configure Environment Variables in Codemagic
In Codemagic **App settings → Environment variables**, create a variable group named `keystore_credentials` with these **Secure** variables:
- `CM_KEYSTORE`: Base64 string of `upload-keystore.jks`
- `CM_KEYSTORE_PASSWORD`: Your keystore password
- `CM_KEY_ALIAS`: `upload` (or your chosen alias)
- `CM_KEY_PASSWORD`: Your key password

*(Optional)* For automated Google Play upload, create a group `google_play_credentials` with `GPLAY_SERVICE_ACCOUNT_CREDENTIALS` (JSON key) and uncomment the `google_play` block in `codemagic.yaml`.

## 4. Trigger the Build
Push to `main` or click **Start new build** in Codemagic. The workflow will:
1. Run `flutter pub get`, `dart format`, `flutter analyze`, and `flutter test`
2. Build `app-debug.apk`
3. Decode your keystore into `android/app/upload-keystore.jks` and write `android/key.properties`
4. Build `app-release.apk` and `app-release.aab` (with R8 shrinking & obfuscation enabled via `android/app/proguard-rules.pro`)
5. Collect all artifacts under `build/app/outputs/flutter-apk/*.apk` and `build/app/outputs/bundle/release/*.aab`
