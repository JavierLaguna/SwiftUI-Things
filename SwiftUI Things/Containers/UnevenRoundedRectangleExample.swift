import SwiftUI

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
