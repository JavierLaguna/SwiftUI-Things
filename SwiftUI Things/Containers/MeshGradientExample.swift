import SwiftUI

struct MeshGradientExample: View {
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.5, 1.0], [0.7, 0.5], [1.0, 0.7],
                [0.0, 1.0], [0.0, 0.5], [0.0, 0.5]
            ],
            colors: [
                .teal, .purple, .indigo,
                .purple, .blue, .pink,
                .purple, .red, .purple,
            ]
        )
        .ignoresSafeArea()
        .shadow(
            color: .gray,
            radius: 25,
            x: -10,
            y: 10
        )
    }
}

#Preview {
    MeshGradientExample()
}
