import SwiftUI

extension UnevenRoundedRectangleExample: NativeComponentThing {
    static let title = "UnevenRoundedRectangle"
    static func makeView() -> some View { Self() }
}

struct UnevenRoundedRectangleExample: View {

    var body: some View {
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
    }
}

#Preview {
    UnevenRoundedRectangleExample()
}
