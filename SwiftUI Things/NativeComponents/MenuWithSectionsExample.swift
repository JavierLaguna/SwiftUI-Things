import SwiftUI
import iOS26Macros

extension MenuWithSectionsExample: NativeComponentThing {
    static let title = "Menu with sections"
    static func makeView() -> some View { Self() }
}

struct MenuWithSectionsExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Menu {
                Section {
                    Button {
                        // Empty
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }

                    Button {
                        // Empty
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }

                Section("Section name") {
                    Button {
                        // Empty
                    } label: {
                        Label("More", systemImage: "ellipsis")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        // Empty
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }

            } label: {
                Label("More", systemImage: "ellipsis.circle")
                    .foregroundStyle(.purple)
            }
            .menuOrder(.fixed)
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    MenuWithSectionsExample()
}
