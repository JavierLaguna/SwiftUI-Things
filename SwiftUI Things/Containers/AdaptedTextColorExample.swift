
import SwiftUI

struct AdaptedTextColorExample: View {
    
    private let colors: [Color] = [
        .red,
        .green,
        .blue,
        .yellow,
        .purple,
        .black,
        .white,
        .cyan,
        .brown,
        .gray,
        .orange,
        .indigo,
        .mint,
    ]
    
    @State private var color: Color = .red
    
    var body: some View {
        Circle()
            .fill(color)
            .overlay {
                Text("Adapted Text Color")
                    .foregroundStyle(color.adaptedTextColor())
            }
            .onTapGesture {
                color = colors.randomElement() ?? .red
            }
    }
}

#Preview {
    AdaptedTextColorExample()
}
