import SwiftUI
import iOS26Macros

extension AdaptedTextColorExample: CustomModifiersThing {
    static let title = "AdaptedTextColor"
    static func makeView() -> some View { Self() }
}

struct AdaptedTextColorExample: View {

    private let colors: [Color] = [
        .red,
        .green,
        .blue,
        .yellow,
        .purple,
        .black,
        .white,
        .cyan,
        .brown,
        .gray,
        .orange,
        .indigo,
        .mint,
    ]

    @State private var color: Color = .red

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Circle()
                .fill(color)
                .overlay {
                    Text("Adapted Text Color")
                        .foregroundStyle(color.adaptedTextColor())
                }
                .onTapGesture {
                    color = colors.randomElement() ?? .red
                }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Custom Modifier", icon: "paintbrush.pointed"),
            ],
            description: "A custom Color extension computes luminance and returns a contrasting text color (black on light backgrounds, white on dark ones). Tap the circle to cycle through a random color and watch the text adapt.",
            code: code,
            preview: { preview }
        )
    }
}

private extension Color {

    func luminance() -> Double {
        let uiColor = UIColor(self)

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)

        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }

    func isLight() -> Bool {
        return luminance() > 0.5
    }

    func adaptedTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
}

#Preview {
    AdaptedTextColorExample()
}
