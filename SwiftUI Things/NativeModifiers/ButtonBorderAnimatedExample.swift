import SwiftUI
import iOS26Macros

extension ButtonBorderAnimatedExample: NativeModifiersThing {
    static let title = "ButtonBorderAnimated"
    static func makeView() -> some View { Self() }
}

struct ButtonBorderAnimatedExample: View {

    private let gradient = Gradient(colors: [.red, .blue])

    @State private var isAnimating = false

    var body: some View {
        let (preview, code) = #CodeSnippet(
            ZStack {
                LinearGradient(
                    gradient: gradient,
                    startPoint: isAnimating ? .topTrailing : .bottomLeading,
                    endPoint: isAnimating ? .bottomTrailing : .center
                )
                .animation(
                    .easeInOut(duration: 1).repeatForever(autoreverses: true),
                    value: isAnimating
                )
                .frame(width: 200, height: 86)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .blur(radius: 8)

                Button("Button") {
                    // Empty
                }
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 200, height: 80)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .ignoresSafeArea()
            .onAppear {
                isAnimating.toggle()
            }
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "An animated glowing border effect created with a LinearGradient that shifts its start and end points in an infinite repeating animation. The gradient sits behind a styled button with a blurred overlay to produce a neon glow.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    ButtonBorderAnimatedExample()
}
