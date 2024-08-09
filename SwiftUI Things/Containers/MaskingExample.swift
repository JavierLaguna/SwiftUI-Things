import SwiftUI

struct MaskingExample: View {
    
    var body: some View {
        Image(.sonoma)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .mask {
                Image(systemName: "apple.logo")
                    .font(.system(size: 300))
            }
            .shadow(radius: 10)
    }
}

#Preview {
    MaskingExample()
}
