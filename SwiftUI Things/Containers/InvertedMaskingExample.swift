import SwiftUI

struct InvertedMaskingExample: View {
    var body: some View {
        ZStack {
            Image(.sonoma)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(systemName: "apple.logo")
                .font(.system(size: 300))
                .blendMode(.destinationOut)
        }
        .compositingGroup()
        .shadow(
            color: .gray,
            radius: 15,
            x: -10,
            y: 10
        )
    }
}

#Preview {
    InvertedMaskingExample()
}
