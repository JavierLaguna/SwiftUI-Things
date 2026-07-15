import SwiftUI
import iOS26Macros

extension InspectorExample: NativeModifiersThing {
    static let title = "Inspector"
    static func makeView() -> some View { Self() }
}

struct InspectorExample: View {

    @State private var showInspector = false

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Button {
                showInspector.toggle()

            } label: {
                Image(systemName: "gamecontroller")
                    .font(.system(size: 120))
                    .foregroundStyle(.purple, .gray)
            }
            .inspector(isPresented: $showInspector) {
                Text("More options for this controller")
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Demonstrates the .inspector modifier that presents a trailing panel when a game controller button is tapped, using @State to toggle the inspector visibility.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    InspectorExample()
}
