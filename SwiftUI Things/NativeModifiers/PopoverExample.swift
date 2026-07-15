import SwiftUI
import iOS26Macros

extension PopoverExample: NativeModifiersThing {
    static let title = "Popover"
    static func makeView() -> some View { Self() }
}

struct PopoverExample: View {

    @State private var showPopover = false

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Button(action: {
                showPopover.toggle()
            }) {
                Text("Show Popover")
            }
            .popover(isPresented: $showPopover, attachmentAnchor: .point(.top)) {
                PopoverView()
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "A button that presents a popover anchored to the top of the button using .popover(isPresented:attachmentAnchor:). The popover content is a custom PopoverView with .presentationCompactAdaptation(.none).",
            code: code,
            preview: { preview }
        )
    }
}

private struct PopoverView: View {

    var body: some View {
        VStack {
            Text("👋🏻")
        }
        .presentationCompactAdaptation(.none)
    }
}

#Preview {
    PopoverExample()
}
