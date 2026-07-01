import SwiftUI
import iOS26Macros

extension ImageAndTextExample: NativeComponentThing {
    static let title = "Image and text"
    static func makeView() -> some View { Self() }
}

struct ImageAndTextExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Text("SwiftUI ")
            +
            Text(Image(systemName: "apple.logo"))
                .foregroundStyle(.colorGrapefruitDark)
                .font(.title)
            +
            Text(" Things!!")
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
    ImageAndTextExample()
}
