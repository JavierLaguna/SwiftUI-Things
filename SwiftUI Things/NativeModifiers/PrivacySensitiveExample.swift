import SwiftUI
import iOS26Macros

extension PrivacySensitiveExample: NativeModifiersThing {
    static let title = "Privacy sensitive"
    static func makeView() -> some View { Self() }
}

struct PrivacySensitiveExample: View {

    @State private var hideContent = true

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "key.fill")

                    Toggle("Privacy Sensitive", isOn: $hideContent)
                }
                .font(.title)

                Text("Hello, World!")
                    .font(.title3)
                    .privacySensitive(hideContent)
                    .redacted(reason: .privacy)
            }
            .padding(.horizontal, 24)
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Uses .privacySensitive(_:) and .redacted(reason: .privacy) to conditionally hide text content when the toggle is on, protecting sensitive information from screen captures or recording.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    PrivacySensitiveExample()
}
