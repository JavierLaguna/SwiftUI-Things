import SwiftUI
import iOS26Macros

extension DisplayArrayUserFriendlyExample: NativeModifiersThing {
    static let title = "Display array user friendly"
    static func makeView() -> some View { Self() }
}

struct DisplayArrayUserFriendlyExample: View {

    private let items = [
        "iPad Pro",
        "iPad Air",
        "iPad mini",
    ]

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("No friendly")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Text("\(items)")
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Type list + and")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Text(items.formatted(.list(type: .and)))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text("Type list + or")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Text(items.formatted(.list(type: .or)))
                }
            }
            .padding()
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Compares raw array string interpolation against .formatted(.list(type:)) with .and and .or styles to produce user-friendly list output from a string array.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    DisplayArrayUserFriendlyExample()
}
