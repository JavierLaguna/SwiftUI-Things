import SwiftUI

struct GlowingGradientBorder: View {
    
    var body: some View {
        Text("PREMIUM")
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                    .shadow(color: .teal.opacity(0.9), radius: 10)
                    .frame(width: 225, height: 75)
            }
    }
}

#Preview {
    GlowingGradientBorder()
}
