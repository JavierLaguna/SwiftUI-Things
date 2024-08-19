import SwiftUI

struct MorphingSymbolViewExample: View {
    
    @State private var active = false
    
    var body: some View {
        MorphingSymbolView(
            symbol: active ? "apple.logo" : "apple.meditate",
            config: .init(
                font: .system(size: 100, weight: .bold),
                frame: .init(width: 250, height: 200),
                radius: 15,
                foregroundColor: .black
            )
        )
        .onTapGesture {
            active.toggle()
        }
    }
}

#Preview {
    MorphingSymbolViewExample()
}
