import SwiftUI
import iOS26Macros

extension RotateGestureExample: NativeModifiersThing {
    static let title = "RotateGesture"
    static func makeView() -> some View { Self() }
}

struct RotateGestureExample: View {

    @State private var angle: Angle = .zero

    var body: some View {
        let (preview, code) = #CodeSnippet(
            Image(systemName: "steeringwheel")
                .font(.system(size: 300))
                .shadow(radius: 10)
                .rotationEffect(angle)
                .gesture(
                    RotateGesture()
                        .onChanged {
                            angle = $0.rotation
                        }
                )
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Modifier", icon: "wand.and.stars"),
            ],
            description: "A steering wheel icon that tracks a RotateGesture, updating its .rotationEffect in real time. Two-finger rotation on the image directly controls the wheel angle.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    RotateGestureExample()
}
