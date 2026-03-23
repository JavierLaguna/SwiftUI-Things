# AGENTS.md

## Purpose
This document tells coding agents how to work safely and consistently in this repository.

## Repository Snapshot
- Project: `SwiftUI Things`
- Build system: Xcode project (not SwiftPM)
- Main project file: `SwiftUI Things.xcodeproj`
- Shared scheme: `SwiftUI Things`
- Main target: `SwiftUI Things` (application target)
- Language: Swift (`SWIFT_VERSION = 5.0`)
- iOS deployment target in app target: iOS 18.0
- App style: many SwiftUI examples and sample mini-apps
- Test status: no dedicated unit/UI test target is currently configured

## Source of Truth
- Trust project settings in `SwiftUI Things.xcodeproj/project.pbxproj`
- Trust scheme behavior in `SwiftUI Things.xcodeproj/xcshareddata/xcschemes/SwiftUI Things.xcscheme`
- App entrypoint: `SwiftUI Things/SwiftUI_ThingsApp.swift`
- Navigation and screen registry: `SwiftUI Things/Models/Thing.swift`

## Cursor/Copilot Rules
- `.cursor/rules/`: not present at time of writing
- `.cursorrules`: not present at time of writing
- `.github/copilot-instructions.md`: not present at time of writing
- If any of those files are added later, treat them as higher-priority guidance and update this file.

## Build / Lint / Test Commands

### List project metadata
```bash
xcodebuild -list -project "SwiftUI Things.xcodeproj"
```

### Show available destinations
```bash
xcodebuild -showdestinations -project "SwiftUI Things.xcodeproj" -scheme "SwiftUI Things"
```

### Build for iOS Simulator
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  build
```

### Build for generic iOS device
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  -configuration Debug \
  -destination 'generic/platform=iOS' \
  build
```

### Analyze (closest equivalent to lint in this repo)
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  -configuration Debug \
  analyze
```

### Clean
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  clean
```

### Test (current status)
There is no test target configured right now, so `xcodebuild test` has no project tests to execute.

When a test target is added, run:
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  test
```

### Run a single test (when tests exist)
Use `-only-testing`:
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:"<TestTarget>/<TestClass>/<testMethod>" \
  test
```

Example:
```bash
xcodebuild \
  -project "SwiftUI Things.xcodeproj" \
  -scheme "SwiftUI Things" \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:"SwiftUIThingsTests/MainViewModelTests/testLoadsItems" \
  test
```

## Lint / Format Policy
- No SwiftLint config found (`.swiftlint.yml` is absent)
- No SwiftFormat config found (`.swiftformat` is absent)
- No custom lint scripts are configured in the Xcode project
- For now, rely on compiler warnings and `xcodebuild analyze`
- Maintain style by following nearby files in the same folder
- Do not introduce new formatter/linter tooling unless explicitly requested

## Code Style Guidelines

### Imports
- Keep imports minimal per file.
- Most UI files import only `SwiftUI`.
- Add framework imports only when needed (for example `MapKit`, `PhotosUI`, `PDFKit`, `StoreKit`, `AVFoundation`).
- Use one import per line.

### File organization
- Common pattern:
  1) imports
  2) conformance extension used by the registry (`extension Foo: NativeModifiersThing`)
  3) main type (`struct Foo: View`)
  4) private helper types/extensions
  5) `#Preview`
- If the existing file uses a different local structure, preserve it.

### Formatting
- Use 4-space indentation.
- Avoid trailing whitespace.
- Prefer readable multi-line SwiftUI modifier chains for complex view trees.
- Use blank lines to separate logical blocks.
- Keep lines review-friendly; no strict max line length is configured.

### Types and state
- Prefer `struct` for views and value types.
- Use `final class` for `ObservableObject` view models.
- Keep access control as restrictive as practical (`private`, `private(set)`).
- Use explicit type annotations when intent is not obvious.
- Prefer computed properties for derived display values.

### Naming conventions
- Types/protocols/enums: UpperCamelCase.
- Variables/functions/properties: lowerCamelCase.
- Example screens commonly end with `Example`, `View`, `Sandbox`, or `App`.
- Category conformance should align with existing protocols:
  - `IOS26Thing`
  - `CustomComponentThing`
  - `NativeComponentThing`
  - `CustomModifiersThing`
  - `NativeModifiersThing`
  - `NativeEnvironmentThing`
  - `SampleAppThing`

### SwiftUI patterns
- Keep `body` declarative and focused.
- Extract repeated or dense UI into private helper builders/properties.
- Use property wrappers idiomatically (`@State`, `@ObservedObject`, `@Environment`).
- Keep previews enabled and compiling (`#Preview` is standard across repo).

### Error handling
- Avoid new crash-prone code (`!`) unless guaranteed safe.
- Prefer `guard`/`if let` over force unwraps.
- Use explicit error handling for new non-trivial logic when possible.
- Existing code sometimes uses `try?` and `print`; do not expand that pattern unnecessarily.

### Concurrency
- Use `Task`/`await` for async UI interactions where needed.
- Consider cancellation and lifecycle when launching async work.
- Ensure UI state updates are performed safely on the main actor/context.

### Comments
- Keep comments concise and purposeful.
- Comment non-obvious intent, trade-offs, or caveats; avoid narrating obvious code.
- Preserve existing credit comments when editing adapted examples.

## Repository-specific implementation rules
- Make focused edits; avoid broad refactors unless requested.
- Preserve naming and registry patterns used by `ThingRegistry`.
- If you add a new demo screen, register it in `ThingRegistry.bySection`.
- Keep asset/resource usage aligned with existing folder layout.
- Do not add dependencies or new tooling config unless explicitly requested.
- If tests are introduced later, add target wiring and then update command examples.

## Pre-PR / Pre-commit checklist
- Build succeeds with `xcodebuild` on a simulator destination.
- No accidental resource path or asset name breakage.
- New/updated screens are reachable from registry when applicable.
- `#Preview` still compiles in touched files.
- `xcodebuild analyze` run for changed areas.

## Additional notes
- SonarCloud metadata exists in `.sonarcloud.properties`.
- No local Sonar execution script is configured in this repository.
- Revisit this file when targets, schemes, build settings, or tooling change.
