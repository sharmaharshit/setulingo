# SetuLingo — Spoken Kannada for Hindi Speakers

SetuLingo is a Play Store-oriented Flutter application designed for Hindi speakers to understand and speak natural everyday Kannada **without needing to learn Kannada script**. Every phrase, lesson, scenario, number, and generated sentence supports three synchronized representations:

1. **Hindi** (meaning and translation)
2. **Devanagari** (Devanagari-script Kannada pronunciation)
3. **Roman Hindi** (comfortable Romanized pronunciation)

## Feature Summary
- **Global Reader Mode**: Switch between Devanagari + Roman, Devanagari only, or Roman Hindi only from any screen; persisted locally.
- **Guided Home & Do Next**: Surfaces *Do Next*, *Today's 2-Minute Scenario*, *Continue Learning*, progress overview, *Kannada Numbers*, *Vault Quiz*, and *Sentence Lab*.
- **Eight Real Spaces (40 Scenarios)**: 8 everyday contexts × 5 scenarios each (Ordering Food & Restaurants, Auto/Metro/Transportation, Shopping & Markets, Work & Office, Home & Neighbourhood, Healthcare & Emergencies, Social Conversations, Everyday Problems & Survival).
- **Guided Lesson Engine (`LessonPage`)**: 4 structured step types (`PhraseStep`, `SpeakPracticeStep`, `BuildStep`, `UseStep`) with persistent progress and retry support.
- **Sentence Lab (81-Word Tagged Engine)**: 22 Anchors × 32 Nouns × 27 Verbs/Predicates with strict tag-based compatibility filtering and dynamic sentence assembly.
- **Sanskrit / Tatsama Root Bridge**: 40 curated comparative connections distinguishing Tatsama forms, Sanskrit-derived forms, direct cognates, and broader areal relationships.
- **Saved Vault & Vault Quiz**: Bookmark phrases from Real Spaces or Sentence Lab, search, listen, delete, and quiz yourself.
- **Global Search**: Instant categorized search across all datasets and scripts.
- **Local Authentication & Profile**: Sign-up/sign-in with phone and Gmail/email validation in clearly labeled Local Profile Mode, structured with `AuthProviderInterface` for future backend integration.
- **Audio & Pronunciation (`AudioService`)**: Uses `flutter_tts` with Kannada (`kn-IN` / `kn`) detection, Hindi/English fallback, overlap prevention, and explicit unavailable-audio feedback.

## Project Structure
```text
SetuLingo/
├── android/                 # Android Gradle, Manifest, ProGuard/R8, signing template, icons
├── lib/
│   ├── data/                # Curated datasets (40 scenarios, 81 Sentence Lab words, 40 Root Bridges, Numbers, Lessons)
│   ├── models/              # Immutable typed models with JSON serialization
│   ├── screens/             # AuthPage, MainShell, HomePage, RealSpaces, LessonPage, SentenceLab, RootBridge, Vault, Numbers, Profile
│   ├── services/            # PersistenceService, AudioService, SentenceEngine, SearchService
│   ├── stores/              # UserAuthStore, AppStateStore, VaultStore (ChangeNotifier + Provider)
│   ├── theme/               # Editorial paper-and-ink AppTheme (zero Kannada fonts)
│   ├── widgets/             # TriScriptView, ReaderModePill, AudioPlayButton, GlobalSearchPage, EditorialCard
│   ├── app.dart
│   └── main.dart
├── test/                    # Dataset integrity, SentenceEngine, persistence, search, and widget tests
├── codemagic.yaml           # CI/CD workflow for validation, debug APK, release APK, and release AAB
├── CODEMAGIC_SETUP.md       # Detailed Codemagic & Android signing setup guide
└── pubspec.yaml
```

## Dependencies
- `flutter_tts: ^4.0.2` — Device Text-to-Speech pronunciation
- `provider: ^6.1.2` — State management
- `shared_preferences: ^2.3.2` — Local persistence
- `intl: ^0.20.2` — Date formatting for daily scenario tracking
- `material_ui: ^1.11.1` — Standalone Flutter Material widget library
- `flutter_lints: ^4.0.0` (dev) — Static analysis

## Local Setup & Source Validation
1. Ensure Flutter SDK 3.47+ with Dart SDK 3.13+ is installed (required by `material_ui`).
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Format, analyze, and test:
   ```bash
   dart format --output=none --set-exit-if-changed .
   flutter analyze
   flutter test
   ```
4. Run on a connected Android device or emulator:
   ```bash
   flutter run
   ```

## GitHub Upload Instructions
1. Extract `SetuLingo_GitHub_Ready.zip` into a clean local folder.
2. Initialize Git and push to your GitHub repository:
   ```bash
   cd SetuLingo
   git init
   git add .
   git commit -m "Initial SetuLingo Flutter source"
   git branch -M main
   git remote add origin https://github.com/<your-username>/<your-repo>.git
   git push -u origin main
   ```

## Codemagic & Android Signing
See [CODEMAGIC_SETUP.md](CODEMAGIC_SETUP.md) for step-by-step instructions on connecting GitHub to Codemagic, configuring `keystore_credentials`, and generating signed `.apk` and `.aab` artifacts.

## Google Play Preparation Checklist
- [ ] Generate an upload keystore (`keytool -genkey -v -keystore upload-keystore.jks ...`)
- [ ] Add `CM_KEYSTORE`, `CM_KEYSTORE_PASSWORD`, `CM_KEY_ALIAS`, `CM_KEY_PASSWORD` in Codemagic
- [ ] Run the `SetuLingo Android Build & Release` workflow in Codemagic to produce `app-release.aab`
- [ ] Complete Play Console Data Safety form (local-only profile storage) and store listing screenshots
- [ ] Upload `app-release.aab` to Internal Testing track first
