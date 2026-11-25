# Codemagic & Android Signing Setup Guide

This guide builds **SetuLingo** (`com.setulingo.app`) on Codemagic and collects an Android debug APK. If signing credentials are configured, it also builds a release APK and Play Store App Bundle (AAB).

## 1. Connect GitHub to Codemagic

1. Log in to [Codemagic](https://codemagic.io/) and add the `sharmaharshit/setulingo` repository.
2. Select **Flutter App (via codemagic.yaml)** as the configuration source.
3. Make sure the workflow is using the committed `codemagic.yaml`. The workflow deliberately does not hardcode a premium build-machine type; Codemagic will use an instance available to your account.

## 2. Start with a debug build

The workflow can produce a debug APK without any signing secrets. It runs package resolution, Dart formatting, static analysis and tests before building.

The Android Gradle wrapper scripts/JAR are currently not tracked in this repository. The workflow therefore downloads Gradle 8.11.1 and generates the wrapper at build time. This avoids a missing-`gradlew` failure while keeping generated binaries out of Git.

## 3. Optional: configure a signed release build

To create an APK suitable for distribution and an AAB for Google Play, generate an upload keystore locally. Keep the keystore private and never commit it to Git:

```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Encode the keystore as Base64:

- **macOS:** `base64 -i upload-keystore.jks | pbcopy`
- **Linux:** `base64 -w 0 upload-keystore.jks`
- **Windows PowerShell:** `[Convert]::ToBase64String([IO.File]::ReadAllBytes("upload-keystore.jks"))`

In Codemagic **App settings → Environment variables**, add these four variables and mark them **Secure**:

- `CM_KEYSTORE`: Base64 contents of `upload-keystore.jks`
- `CM_KEYSTORE_PASSWORD`: Keystore password
- `CM_KEY_ALIAS`: `upload` (or your chosen alias)
- `CM_KEY_PASSWORD`: Key password

No environment-variable group is required by the YAML. If `CM_KEYSTORE` is absent, Codemagic intentionally skips release builds instead of producing a misleading debug-signed release artifact.

## 4. Run the workflow

Push to `main` or start `android-workflow` manually. Expected outputs:

- Always: `app-debug.apk`
- Only when the four signing variables are configured: `app-release.apk` and `app-release.aab`

The project targets Android API 36 and uses Android Gradle Plugin 8.9.1, Gradle 8.11.1, Kotlin Gradle Plugin 2.1.0 and Java 17.
