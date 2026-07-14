import SwiftUI
import iOS26Macros

extension NestedMenusExample: NativeComponentThing {
    static let title = "Nested menus"
    static func makeView() -> some View { Self() }
}

struct NestedMenusExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Menu {
                Button(role: .destructive) {
                    // Empty
                } label: {
                    Label("Delete", systemImage: "trash")
                }

                Menu {
                    Button("Share with Friends") {
                        // Empty
                    }

                    Button("Share on Device") {
                        // Empty
                    }
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }

                Button {
                    // Empty
                } label: {
                    Label("Edit", systemImage: "pencil")
                }

            } label: {
                Label("More", systemImage: "ellipsis.circle")
                    .foregroundStyle(.purple)
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            description: "Demonstrates a native Menu with a nested submenu, including a destructive action and a Share submenu containing two options.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    NestedMenusExample()
}
