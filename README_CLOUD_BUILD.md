# SetuLingo — Cloud APK Build (Corrected)

This project is designed for cloud-only Android APK building. You do not need Flutter or Android Studio installed locally.

## Recommended: Codemagic

1. Upload the contents of this folder to the root of a GitHub repository.
2. Make sure `pubspec.yaml`, `lib/`, `assets/`, `android/`, and `codemagic.yaml` are visible at the repository root.
3. In Codemagic, add/select the GitHub repository.
4. Make sure Codemagic detects the `codemagic.yaml` in the repository root.
5. Start the `setulingo-android-debug` workflow.
6. The workflow first generates the complete Android platform with `flutter create --platforms=android --org com.setulingo .`, then runs `flutter pub get`, `flutter analyze`, and `flutter build apk --debug`.
7. Download the APK from the build's Artifacts section: `app-debug.apk`.

Important: the `android/` directory is intentionally included in the repository so Codemagic does not skip the Android build during platform detection. The actual Android Gradle project is generated in the first build script.

## Alternative: GitHub Actions

The `.github/workflows/build-apk.yml` workflow also generates Android, gets dependencies, analyzes the project, builds the debug APK, and uploads it as a GitHub Actions artifact.
