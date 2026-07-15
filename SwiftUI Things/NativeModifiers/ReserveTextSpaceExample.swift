import SwiftUI
import iOS26Macros

extension ReserveTextSpaceExample: NativeModifiersThing {
    static let title = "Reserve text space"
    static func makeView() -> some View { Self() }
}

struct ReserveTextSpaceExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(spacing: 32) {
                Text("No reserved space text!")
                    .lineLimit(2)
                    .background(.mint)

                Text("Reserved space text!")
                    .lineLimit(2, reservesSpace: true)
                    .background(.mint)

            }
            .font(.largeTitle)
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Compares .lineLimit(2) with and without reservesSpace: true. The second variant pre-allocates vertical space for two lines, preventing layout shifts when content loads.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    ReserveTextSpaceExample()
}
