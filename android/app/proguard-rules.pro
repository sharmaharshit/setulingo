# SetuLingo R8 / ProGuard Rules
# Keep Flutter engine and plugin classes used by flutter_tts and shared_preferences.

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# flutter_tts plugin reflection & Android TTS callbacks
-keep class com.tundralabs.fluttertts.** { *; }
-dontwarn com.tundralabs.fluttertts.**

# shared_preferences plugin
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# Kotlin coroutines / annotations
-dontwarn kotlinx.coroutines.**
-keepattributes *Annotation*
