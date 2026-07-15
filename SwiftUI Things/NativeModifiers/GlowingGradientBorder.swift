import SwiftUI
import iOS26Macros

extension GlowingGradientBorder: NativeModifiersThing {
    static let title = "GlowingGradientBorder"
    static func makeView() -> some View { Self() }
}

struct GlowingGradientBorder: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack {
                Text("PREMIUM")
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                            .shadow(color: .teal.opacity(0.9), radius: 10)
                            .frame(width: 225, height: 75)
                    }
            }
            .padding(.vertical, 50)
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "A glowing gradient border created with a RoundedRectangle .stroke overlay using blue-to-purple LinearGradient and a teal shadow for the glow effect.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    GlowingGradientBorder()
}
