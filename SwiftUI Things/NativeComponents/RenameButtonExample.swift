import SwiftUI
import iOS26Macros

extension RenameButtonExample: NativeComponentThing {
    static let title = "RenameButton"
    static func makeView() -> some View { Self() }
}

struct RenameButtonExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            RenameButton()
                .renameAction {
                    print("rename something")
                }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            description: "A native RenameButton wired to a renameAction closure. The button only appears in a context that supports renaming (e.g. a navigation toolbar), and the closure is invoked when the user confirms a rename.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    RenameButtonExample()
}
