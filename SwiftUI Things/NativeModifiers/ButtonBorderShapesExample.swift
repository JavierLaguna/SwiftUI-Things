import SwiftUI
import iOS26Macros

extension ButtonBorderShapesExample: NativeModifiersThing {
    static let title = "ButtonBorderShapes"
    static func makeView() -> some View { Self() }
}

struct ButtonBorderShapesExample: View {

    @ViewBuilder
    private func buttonExample(
        name: String,
        buttonBorderShape: ButtonBorderShape
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(name)
                .font(.title2.bold())

            Button(action: {
                // Empty
            }, label: {
                Image(systemName: "trash")
            })
            .tint(.red)
            .buttonStyle(.bordered)
            .buttonBorderShape(buttonBorderShape)
        }
    }

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack(alignment: .leading, spacing: 40) {
                buttonExample(name: "roundedRectangle", buttonBorderShape: .roundedRectangle)
                buttonExample(name: "roundedRectangle custom radius", buttonBorderShape: .roundedRectangle(radius: 2))
                buttonExample(name: "capsule", buttonBorderShape: .capsule)
                buttonExample(name: "circle", buttonBorderShape: .circle)
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Demonstrates the four .buttonBorderShape variants — roundedRectangle (default and custom radius), capsule, and circle — applied to bordered red trash buttons.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    ButtonBorderShapesExample()
}
