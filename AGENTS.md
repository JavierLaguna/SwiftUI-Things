# AGENTS.md — SwiftUI Things

## Project
- **Build**: `SwiftUI Things.xcodeproj`, single scheme `SwiftUI Things`, single target (app).
- **Xcode**: 16 (`LastUpgradeCheck = 2600`), **Swift 5.0**.
- **Min target**: iOS 18.0 (target-level override; project default 16.2 is irrelevant).
- **Device family**: iPhone + iPad (`TARGETED_DEVICE_FAMILY = "1,2"`).
- **Bundle ID**: `com.jlagunadev.SwiftUI-Things`.
- **No test targets** exist. Scheme has `shouldAutocreateTestPlan = YES` but no test configuration.

## Build & Run
```bash
# List targets/configs
xcodebuild -list -project "SwiftUI Things.xcodeproj"

# Build for simulator
xcodebuild -project "SwiftUI Things.xcodeproj" -scheme "SwiftUI Things" \
  -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 17' build

# Analyze (closest to lint)
xcodebuild -project "SwiftUI Things.xcodeproj" -scheme "SwiftUI Things" \
  -configuration Debug analyze

# Clean
xcodebuild -project "SwiftUI Things.xcodeproj" -scheme "SwiftUI Things" clean
```

## Architecture
- **Entrypoint**: `SwiftUI Things/SwiftUI_ThingsApp.swift` → `MainView()`.
- **Screen registry**: `SwiftUI Things/Models/Thing.swift`.
  - Protocol `Thing` with associated `FeatureView`. Seven conformance protocols map to `ThingSection`: `IOS26Thing`, `CustomComponentThing`, `NativeComponentThing`, `CustomModifiersThing`, `NativeModifiersThing`, `NativeEnvironmentThing`, `SampleAppThing`.
  - `ThingRegistry.bySection` is the source of truth for navigation content.
  - **Registration pattern** — every example screen adds a conformance extension at the top of its file:
    ```swift
    extension MyExample: SomeThingProtocol {
        static let title = "My Screen Title"
        static func makeView() -> some View { Self() }
    }
    ```
- **iOS 26 features**: Use `#available(iOS 26.0, *)` guards. A helper file `AAAAA.swift` provides `ifAvailableiOS26(_:else:)` and `ifNotAvailableiOS26(_:)` view modifiers.
- **StoreKit testing**: The scheme references `SwiftUI Things/Subscription.storekit` (one subscription group "Pro" with weekly/monthly/yearly product IDs, no real products configured).

## Repository Quirks
- **NativeEnvironments group cleaned**: `NativeEnvironments/` contained 34 file copies (same content) of `NativeModifiers/` files plus one unique file (`DetermineLightDarkModeExample.swift`). Duplicates were removed from pbxproj and disk. `NativeEnvironments` now only contains `DetermineLightDarkModeExample.swift` — edit the canonical copy in `NativeModifiers/` for the other files.
- **No linter/formatter** config (no `.swiftlint.yml`, `.swiftformat`, or lint build phases). Rely on compiler warnings + `analyze`.
- **Audio**: `Resources/Sounds/chimeup.mp3`, `Resources/Sounds/success.m4a`. Used via the global `playSound(sound:type:)` in `Utilities/AudioPlayer.swift`.

## SwiftUI Expert Skill

This project's SwiftUI code should be written, reviewed, and refactored using the `swiftui-expert-skill` (available in the OpenCode skill registry). Always load it via the `skill` tool before starting any SwiftUI task. It provides:

- **Correctness checklist**: hard rules like `@State` being `private`, `ForEach` with stable identity, `.animation(_:value:)` requiring the `value` parameter, iOS 26+ API gating with `#available`, etc.
- **Reference files** covering state management, view composition, performance, layouts, accessibility, animations, charts, image optimization, and Liquid Glass patterns.
- **Latest APIs reference** (`latest-apis.md`) to avoid deprecated APIs — read this first.
- **Liquid Glass** guidance only when explicitly requested (not a default).

## File Conventions
1. imports
2. `extension MyType: CategoryThing { … }` conformance
3. main `struct MyType: View`
4. private helpers/extensions
5. `#Preview`
- Indent: 4 spaces. No trailing whitespace.
- Keep `#Preview` compiling in every touched file.
- New screens must be registered in `ThingRegistry.bySection` to appear in the navigation.
