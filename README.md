# SetuLingo — APK-ready Flutter MVP

This repository is prepared for a direct Android APK build.

## Fastest Windows build

1. Install Flutter: https://docs.flutter.dev/get-started/install/windows
2. Install Android Studio and the Android SDK.
3. Extract this project.
4. Double-click `build_apk.bat`.
5. When it finishes, the APK is at:

`build\\app\\outputs\\flutter-apk\\app-debug.apk`

Copy that APK to an Android phone and install it.

## Command-line build

```powershell
flutter create --platforms=android --org com.setulingo .
flutter pub get
flutter analyze
flutter build apk --debug
```

## GitHub one-click build

Push this folder to a GitHub repository. Open **Actions → Build SetuLingo APK → Run workflow**. The workflow generates the Android platform, builds the debug APK, and uploads it as an artifact named `setulingo-debug-apk`.

## Current MVP content

Days 1 and 2 contain the supplied production seed content. Days 3–30 are scaffolded and locked for later content expansion. Audio files are optional at this stage; the app can be exercised without the final audio bundle.

## Requirements

- Flutter stable
- Android SDK / Android Studio
- Android SDK suitable for the current Flutter stable toolchain
- Internet access is only needed for the initial dependency/build setup; the resulting app core loop is offline-first.
