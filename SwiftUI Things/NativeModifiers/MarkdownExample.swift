import SwiftUI
import iOS26Macros

extension MarkdownExample: NativeModifiersThing {
    static let title = "Markdown text"
    static func makeView() -> some View { Self() }
}

struct MarkdownExample: View {

    let textContent: LocalizedStringKey = """
    **Creating a Text View in SwiftUI**

    *The example below shows how to create a simple text view:*


    `Text("Hello, World!")`


    This is a SwiftUI Things example [Github](https://github.com/JavierLaguna/SwiftUI-Things).
    """

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Text(textContent)
                .font(.title)
                .padding()
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Renders Markdown-formatted text using LocalizedStringKey, supporting bold, italics, inline code, and links through SwiftUI's native Text initializer.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    MarkdownExample()
}
