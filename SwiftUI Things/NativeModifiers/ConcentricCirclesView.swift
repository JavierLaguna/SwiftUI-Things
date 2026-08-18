import SwiftUI
import iOS26Macros

extension ConcentricCirclesView: NativeModifiersThing {
    static let title = "Concentric Circles"
    static func makeView() -> some View { Self() }
}

struct ConcentricCirclesView: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Circle()
                .strokeBorder(.blue.opacity(0.2), lineWidth: 70)
                .strokeBorder(.blue.opacity(0.4), lineWidth: 50)
                .strokeBorder(.blue.opacity(0.5), lineWidth: 30)
                .strokeBorder(.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "Layers multiple strokeBorder modifiers on a Circle to create concentric rings with increasing opacity and thickness.",
            code: code,
            preview: {
                ZStack {
                    Color.black

                    preview
                }
                .padding(.vertical, 16)
            }
        )
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()

        ConcentricCirclesView()
    }
}
