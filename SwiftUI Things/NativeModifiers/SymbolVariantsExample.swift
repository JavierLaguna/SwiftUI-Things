import SwiftUI
import iOS26Macros

extension SymbolVariantsExample: NativeModifiersThing {
    static let title = "Symbol Variants"
    static func makeView() -> some View { Self() }
}

struct SymbolVariantsExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(spacing: 20) {
                Image(systemName: "heart")
                    .symbolVariant(.none)

                Image(systemName: "heart")
                    .symbolVariant(.fill)

                Image(systemName: "heart")
                    .symbolVariant(.circle)

                Image(systemName: "heart")
                    .symbolVariant(.square)

                Image(systemName: "heart")
                    .symbolVariant(.rectangle)

                Image(systemName: "heart")
                    .symbolVariant(.slash)
            }
            .font(.largeTitle)
            .padding()
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "square.3.layers.3d"),
            ],
            description: "The same SF Symbol rendered with different variants using the symbolVariant modifier.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    SymbolVariantsExample()
}