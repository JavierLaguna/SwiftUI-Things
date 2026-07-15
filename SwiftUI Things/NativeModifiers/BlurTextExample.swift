import SwiftUI
import iOS26Macros

extension BlurTextExample: NativeModifiersThing {
    static let title = "Blur Text"
    static func makeView() -> some View { Self() }
}

struct BlurTextExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            HStack {
                Text("This is")

                Text("blurred")
                    .blur(radius: 5)

                Text("text")
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Applies the .blur(radius:) modifier to a single Text view within an HStack, demonstrating how partial text blurring works in SwiftUI.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    BlurTextExample()
}
