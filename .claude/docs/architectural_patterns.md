# Architectural Patterns

## 1. DataType Enum as Central Registry

`DataType` ([lib/constants/app.dart:85-135](../../lib/constants/app.dart#L85-L135)) is the single source of truth that connects every layer of the app. Each enum value carries:

- `value` — the string name used in file paths (`cv-summary.ttl`)
- `icon` — the tab icon
- `tab` — the tab index in the profile editor
- `dataParser` — a function reference (`parseSummary`, `parseEducation`, …)
- Computed getters: `ttlFile`, `ttlFilePath`, `portaitFilePath`

**Consequence**: adding a new CV section requires one new enum entry plus implementations of the corresponding parser, `Item` class, tab UI, and popup set. The fetch loop in `rest_api.dart` and `setCvData`/`getCvData` switches in `cv_manager.dart` iterate over `dataTypeList` automatically.

---

## 2. Singleton State via CvManager

`CvManager` ([lib/utils/cv_manager.dart:42-398](../../lib/utils/cv_manager.dart#L42-L398)) holds all CV data in static Maps — one per section. The instance is created once in `InitialScreen.loadedScreen` and passed down the widget tree as a constructor parameter.

Key methods:
- `initialSetupCvData(cvDataMap)` — bulk-loads all sections after fetch
- `setCvData(DataType, Map)` / `getCvData(DataType)` — per-type typed getters/setters
- `updateCvData(DataType, Map)` / `deleteCvData(DataType, String)` — incremental mutation
- `checkUpdatedDateExpired()` / `updateDate()` ([lib/utils/cv_manager.dart:77, 381-397](../../lib/utils/cv_manager.dart#L381-L397)) — date-string cache invalidation; stale data triggers a re-fetch from the Pod

Static Maps mean data persists across hot reloads but is shared across all `CvManager` instances (which is always just one).

---

## 3. Item Data Model Classes

Every CV section has a corresponding `*Item` class in [lib/utils/cvData/](../../lib/utils/cvData/). All follow this structure:

```
final String createdTime;
final String updatedTime;
// ... section-specific fields
```

Items are created inside `CvManager.setCvData` after parsing raw Map data from the TTL files. They are stored in the section's static Map keyed by a UUID-style identifier (the RDF subject).

---

## 4. RDF Round-Trip (Read → Parse → Display → Write)

**Reading** ([lib/apis/rest_api.dart:60-94](../../lib/apis/rest_api.dart#L60-L94)):
1. `fetchProfileData` iterates `dataTypeList`
2. For each type, calls `readPod(filePath)` (solidpod)
3. Passes raw Turtle string to `getRdfData(content, dataType)` ([lib/utils/rdf.dart:45-48](../../lib/utils/rdf.dart#L45-L48))
4. `getRdfData` calls `parseTTL` then delegates to `dataType.dataParser`

**Parsing** ([lib/utils/rdf.dart:26-43](../../lib/utils/rdf.dart#L26-L43)):
- `parseTTL` uses `rdflib` to parse Turtle into triples, then flattens into `Map<subject, Map<predicate, object>>`
- Fragment identifiers (`#foo`) are stripped from subject/predicate URIs

**Writing** ([lib/utils/gen_turtle_struc.dart](../../lib/utils/gen_turtle_struc.dart)):
- Popup save handlers call a `genTtl*` function to build a Turtle string
- Then call `writePod(filePath, turtleString)` (solidpod)
- Then call `cvManager.updateCvData(...)` to keep in-memory state consistent

---

## 5. CRUD via Popup Dialogs

All create/edit/delete operations follow the same pattern across all 10 CV sections:

**Add** (`lib/widgets/popups/add/*.dart`):
1. `showDialog` with `StatefulBuilder` for local form state
2. `TextEditingController` per field
3. On submit: `genTtl*` → `writePod` → `cvManager.setCvData` → `setState`

**Edit** (`lib/widgets/popups/edit/*.dart`):
1. Same structure; controllers pre-populated with existing `*Item` values
2. On submit: regenerates Turtle for the existing subject UUID → `writePod` → `cvManager.updateCvData`

**Delete** (`lib/widgets/popups/delete/delete.dart`):
1. Generic confirmation dialog shared across all types
2. On confirm: `deletePod(filePath)` or patch + `cvManager.deleteCvData`

---

## 6. PDF Generation Pipeline

[lib/screens/pdf/template.dart](../../lib/screens/pdf/template.dart) defines a registry of `Template` objects. Each has a `LayoutCallbackWithData`:

```dart
typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat, CvManager cvManager, Map dataTypes);
```

The selected template's builder (e.g. `generateResume` in [lib/screens/pdf/templates/template1.dart](../../lib/screens/pdf/templates/template1.dart)) receives the full `CvManager` and a `Map` of which sections to include (chosen via `select_sec_popup.dart`). It calls individual section-widget functions from `lib/widgets/cvCards/` to compose the PDF layout.

---

## 7. Async Loading with FutureBuilder

App startup ([lib/screens/initial_screen.dart:49-99](../../lib/screens/initial_screen.dart#L49-L99)) uses `Future.wait` to parallelize fetching the webId and all Pod data, then renders a loading screen until both resolve. Subsequent screens use `updateProfileData` ([lib/apis/rest_api.dart:48-57](../../lib/apis/rest_api.dart#L48-L57)) which skips the Pod fetch if the cached date has not expired.

---

## 8. Responsive Layout

Breakpoints are defined as constants in [lib/constants/app.dart:79-82](../../lib/constants/app.dart#L79-L82):
- `desktopWidthThreshold = 960`
- `smallMobileWidthThreshold = 500`

Helper functions in [lib/utils/responsive.dart](../../lib/utils/responsive.dart) return layout values (column counts, padding, font sizes) based on `MediaQuery` width. Screens check these to switch between single-column (mobile) and multi-column (desktop) layouts.
