import SwiftUI
import iOS26Macros

extension CountDownExample: NativeComponentThing {
    static let title = "Count Down"
    static func makeView() -> some View { Self() }
}

struct CountDownExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            VStack {
                Text(
                    timerInterval: .now...Date(timeIntervalSinceNow: 90),
                    countsDown: true
                )

                Text(
                    timerInterval: .now...Date(timeIntervalSinceNow: 90),
                    countsDown: false
                )
            }
            .font(.system(size: 150, weight: .black))
            .italic()
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
    CountDownExample()
}
