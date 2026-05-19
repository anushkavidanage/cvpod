# CVPod

A privacy-preserving CV management app backed by [Solid Pods](https://solidproject.org/). Users store structured profile data on their own Pod (in RDF/Turtle format), generate PDF résumés, and share CV sections with other Solid users.

## Tech Stack

- **Language/Framework**: Flutter / Dart (SDK ≥3.4.1)
- **State management**: Singleton class (`CvManager`) — riverpod is a dependency but not actively used
- **Pod integration**: [`solidpod`](https://pub.dev/packages/solidpod) (auth, read/write), [`solidui`](https://pub.dev/packages/solidui) (login widget)
- **RDF**: [`rdflib`](https://pub.dev/packages/rdflib) for parsing Turtle files
- **PDF**: [`pdf`](https://pub.dev/packages/pdf) + [`printing`](https://pub.dev/packages/printing) for generation, [`flutter_pdfview`](https://pub.dev/packages/flutter_pdfview) for display
- **Storage**: `flutter_secure_storage` for local secrets
- **Platforms**: Android, iOS, Web, Windows, Linux, macOS

Full dependency list: [pubspec.yaml](pubspec.yaml)

## Project Structure

```
lib/
├── main.dart               # Entry point — wraps app in SolidLogin
├── apis/
│   └── rest_api.dart       # All Pod HTTP calls (fetch, write, share)
├── constants/
│   ├── app.dart            # DataType enum, layout constants
│   ├── colors.dart         # App color palette
│   ├── schema.dart         # RDF namespace/predicate strings
│   └── sample_content.dart # Demo data for onboarding
├── screens/
│   ├── initial_screen.dart # Post-login data loader (FutureBuilder)
│   ├── home.dart           # Landing dashboard
│   ├── nav/                # Navigation drawer + top-level container
│   ├── profile/            # Tabbed profile editor (10 CV section tabs)
│   ├── pdf/                # PDF template selection + generation
│   ├── settings/           # Encryption key + other settings
│   └── sharing/            # Share CV with / view CVs from other users
├── utils/
│   ├── cv_manager.dart     # Singleton holding all in-memory CV data
│   ├── cvData/             # One *Item data model class per CV section
│   ├── rdf.dart            # Turtle parser + per-type data extractors
│   ├── gen_turtle_struc.dart # Generates Turtle RDF for Pod writes
│   ├── misc.dart           # General helpers
│   └── responsive.dart     # Breakpoint constants + helpers
└── widgets/
    ├── popups/add/         # Add-new-entry dialog per section
    ├── popups/edit/        # Edit-existing-entry dialog per section
    ├── popups/delete/      # Delete confirmation dialog
    ├── cvCards/            # PDF section widgets (one per CV section)
    └── customCards/        # UI display cards (award, publication, referee)
```

## Essential Commands

```bash
# Install dependencies
flutter pub get

# Run (choose target)
flutter run -d chrome          # Web
flutter run -d windows         # Windows desktop
flutter run                    # Connected device/emulator

# Static analysis
flutter analyze

# Tests
flutter test

# Build
flutter build apk              # Android
flutter build web              # Web
flutter build windows          # Windows
```

## Key Entry Points

| File | Lines | Purpose |
|------|-------|---------|
| [lib/main.dart](lib/main.dart) | 30–80 | App root; mounts `SolidLogin` → `InitialScreen` |
| [lib/screens/initial_screen.dart](lib/screens/initial_screen.dart) | 49–99 | Parallel async load of webId + all Pod data |
| [lib/utils/cv_manager.dart](lib/utils/cv_manager.dart) | 42–398 | Central in-memory data store (singleton pattern) |
| [lib/constants/app.dart](lib/constants/app.dart) | 85–151 | `DataType` enum — drives tabs, file paths, and parsers |
| [lib/apis/rest_api.dart](lib/apis/rest_api.dart) | 59–94 | `fetchProfileData` — reads all TTL files from Pod |
| [lib/utils/rdf.dart](lib/utils/rdf.dart) | 26–48 | `parseTTL` + `getRdfData` — parses Turtle into Maps |
| [lib/screens/pdf/template.dart](lib/screens/pdf/template.dart) | 9–31 | PDF template registry + `LayoutCallbackWithData` typedef |

## Additional Documentation

| Document | When to check |
|----------|--------------|
| [.claude/docs/architectural_patterns.md](.claude/docs/architectural_patterns.md) | Understanding data flow, how to add a new CV section, popup/CRUD patterns, RDF integration, PDF generation |
