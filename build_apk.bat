@echo off
setlocal
cd /d "%~dp0"

echo ========================================
echo        SETULINGO APK BUILDER
echo ========================================
echo.

where flutter >nul 2>nul
if errorlevel 1 (
  echo ERROR: Flutter is not installed or not in PATH.
  echo Install Flutter, then run this file again.
  echo https://docs.flutter.dev/get-started/install/windows
  pause
  exit /b 1
)

echo [1/4] Checking Flutter...
flutter --version
if errorlevel 1 goto :fail

echo.
echo [2/4] Generating Android project...
flutter create --platforms=android --org com.setulingo .
if errorlevel 1 goto :fail

echo.
echo [3/4] Getting packages...
flutter pub get
if errorlevel 1 goto :fail

echo.
echo [4/4] Building debug APK...
flutter build apk --debug
if errorlevel 1 goto :fail

echo.
echo ========================================
echo BUILD SUCCESSFUL
echo ========================================
echo APK:
echo %CD%\build\app\outputs\flutter-apk\app-debug.apk
echo.
explorer "%CD%\build\app\outputs\flutter-apk"
pause
exit /b 0

:fail
echo.
echo BUILD FAILED. Read the error above.
pause
exit /b 1
