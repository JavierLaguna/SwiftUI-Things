import SwiftUI
import iOS26Macros

extension DetermineLightDarkModeExample: NativeEnvironmentThing {
    static let title = "Determine Light or DarkMode"
    static func makeView() -> some View { Self() }
}

struct DetermineLightDarkModeExample: View {

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
                .font(.system(size: 100))
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Environment", icon: "globe"),
            ],
            description: "Reads the @Environment value for colorScheme and adapts the displayed label accordingly. The text updates automatically when the user toggles between Light and Dark mode at the system level.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    DetermineLightDarkModeExample()
}
