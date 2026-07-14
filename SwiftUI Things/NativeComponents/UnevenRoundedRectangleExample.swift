import SwiftUI
import iOS26Macros

extension UnevenRoundedRectangleExample: NativeComponentThing {
    static let title = "UnevenRoundedRectangle"
    static func makeView() -> some View { Self() }
}

struct UnevenRoundedRectangleExample: View {

    var body: some View {
        let (preview, code) = #CodeSnippet(
            UnevenRoundedRectangle(
                topLeadingRadius: 90,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 70,
                topTrailingRadius: 0
            )
            .fill(.purple)
            .frame(
                width: 320,
                height: 150
            )
        )

        Storybook(
            title: Self.title,
            badges: [
                .init(title: "Native Component", icon: "square.3.layers.3d"),
            ],
            description: "A native SwiftUI shape with independently configurable corner radii for each corner, filled with purple and constrained to a 320×150 frame.",
            code: code,
            preview: { preview }
        )
    }
}

#Preview {
    UnevenRoundedRectangleExample()
}
